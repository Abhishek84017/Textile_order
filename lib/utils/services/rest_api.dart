import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:textile/constants/api_path.dart';
import 'package:textile/constants/app_constants.dart';
import 'package:textile/models/models.dart';
import 'package:http/http.dart' as http;
import 'package:textile/models/payment_detail_model.dart';

import '../../models/PaymentDetailByIdModel.dart';

class Services {
  Services._();

  /// error message if there is any unhandled or unexpected
  /// error while requesting for any of api
  static const String _errorMessage = 'Something went wrong, please try later';
  static const String _noInternetConnection = 'No internet connection';




  // static Map<String, String> restApiHeaders = <String, String>{
  //   'Content-Type': 'application/json',
  //   'Accept': 'application/json',
  //   'Authorization': ''
  // };

  /// rest apis header with token
  static Map<String, String> get _restApiHeaders => <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
        // HttpHeaders.authorizationHeader: 'Bearer ${kUserProvider.authToken}'
      };

  static final _client = http.Client();

  ///
  static Uri _uri(String authority, String unencodedPath,
          [Map<String, dynamic>? queryParameters]) =>
      Uri.http(authority, unencodedPath, queryParameters);

  //
  static Future<Data<UserModel>> signIn(Map<String, dynamic> body) async {
    Uri url = _uri(Urls.baseUrl, Urls.signIn);
    try {
      http.Response response = await _client.post(url,
          body: jsonEncode(body), headers: _restApiHeaders);
      final jsonResponse = jsonDecode(response.body);
      if (response.statusCode == HttpStatus.ok) {
        return Data.fromJson(jsonResponse)
            .copyWith(data: UserModel.fromJson(jsonResponse['data']));
      }
      return Data.fromJson(jsonResponse);
    } on SocketException catch (_) {
      return const Data(message: _noInternetConnection);
    } catch (e) {
      return const Data(message: _errorMessage);
    }
  }

  //
  static Future<Data<List<OrderModel>>> getActiveOrders() async {
    Uri url = _uri(Urls.baseUrl, Urls.getActiveOrders);
    try {
      http.Response response = await _client.get(url, headers: _restApiHeaders);
      final jsonResponse = jsonDecode(response.body);
      if (response.statusCode == HttpStatus.ok) {
        final orders = <OrderModel>[];
        if (jsonResponse != null) {
          for (final json in jsonResponse) {
            orders.add(OrderModel.fromJson(json));
          }
        }
        return Data.fromResponse(response).copyWith(data: orders);
      }
      return Data.fromJson(jsonResponse);
    } on SocketException catch (_) {
      return const Data(message: _noInternetConnection);
    } catch (e) {
      return const Data(message: _errorMessage);
    }
  }

  //
  static Future<Data<OrderDetailModel>> getOrderDetail(int orderId) async {
    Uri url = _uri(Urls.baseUrl, Urls.getOrderDetail(orderId));
    try {
      http.Response response = await _client.get(url, headers: _restApiHeaders);
      final jsonResponse = jsonDecode(response.body);
      if (response.statusCode == HttpStatus.ok) {
        return Data.fromJson(jsonResponse)
            .copyWith(data: OrderDetailModel.fromJson(jsonResponse));
      }
      return Data.fromJson(jsonResponse);
    } on SocketException catch (_) {
      return const Data(message: _noInternetConnection);
    } catch (e) {
      return const Data(message: _errorMessage);
    }
  }

  //
  static Future<Data> changeOrderStatus(Map<String, dynamic> body) async {
    Uri url = _uri(Urls.baseUrl, Urls.changeOrderStatus);
    try {
      http.Response response = await _client.post(url,
          headers: _restApiHeaders, body: jsonEncode(body));
      final jsonResponse = jsonDecode(response.body);
      if (response.statusCode == HttpStatus.ok) {
        return Data.fromJson(jsonResponse);
      }
      return Data.fromJson(jsonResponse);
    } on SocketException catch (_) {
      return const Data(message: _noInternetConnection);
    } catch (e) {
      return const Data(message: _errorMessage);
    }
  }

  //
  static Future<Data> changeOrderRowStatus(Map<String, dynamic> body) async {
    Uri url = _uri(Urls.baseUrl, Urls.changeOrderRowStatus);
    try {
      http.Response response =
          await _client.post(url, headers: _restApiHeaders);
      final jsonResponse = jsonDecode(response.body);
      if (response.statusCode == HttpStatus.ok) {
        return Data.fromJson(jsonResponse);
      }
      return Data.fromJson(jsonResponse);
    } on SocketException catch (_) {
      return const Data(message: _noInternetConnection);
    } catch (e) {
      return const Data(message: _errorMessage);
    }
  }

  //
  static Future<Data<List<String>>> getOrderStatusList() async {
    Uri url = _uri(Urls.baseUrl, Urls.getOrderStatusList);
    try {
      http.Response response = await _client.get(url, headers: _restApiHeaders);
      final jsonResponse = jsonDecode(response.body);
      if (response.statusCode == HttpStatus.ok) {
        return Data.fromJson(jsonResponse)
            .copyWith(data: List<String>.from(jsonResponse["status_list"]));
      }
      return Data.fromJson(jsonResponse);
    } on SocketException catch (_) {
      return const Data(message: _noInternetConnection);
    } catch (e) {
      return const Data(message: _errorMessage);
    }
  }

  //
  static Future<Data<List<String>>> getOrderRowStatusList() async {
    Uri url = _uri(Urls.baseUrl, Urls.getOrderRowStatusList);
    try {
      http.Response response = await _client.get(url, headers: _restApiHeaders);
      final jsonResponse = jsonDecode(response.body);
      if (response.statusCode == HttpStatus.ok) {
        return Data.fromJson(jsonResponse)
            .copyWith(data: List<String>.from(jsonResponse["status_list"]));
      }
      return Data.fromJson(jsonResponse);
    } on SocketException catch (_) {
      return const Data(message: _noInternetConnection);
    } catch (e) {
      return const Data(message: _errorMessage);
    }
  }


  static Future<Data<List<PaymentDetailModel>>> getActivePayment() async {
    Uri url = _uri(Urls.baseUrl, Urls.getPartyTotalPayment);
    try {
      http.Response response = await _client.get(url, headers: _restApiHeaders);
      final jsonResponse = jsonDecode(response.body);
      kSharedPreferences.setString('totalvalue', jsonResponse['pending']);
      if (response.statusCode == HttpStatus.ok) {
        final payments = <PaymentDetailModel>[];
        if (jsonResponse['data'] != null) {
          for (final json in jsonResponse['data']) {
            payments.add(PaymentDetailModel.fromJson(json));
          }
        }
        return Data.fromResponse(response).copyWith(data: payments);
      }
      return Data.fromJson(jsonResponse);
    } on SocketException catch (_) {
      return const Data(message: _noInternetConnection);
    } catch (e) {
      return const Data(message: _errorMessage);
    }
  }


  static Future<Data<List<PaymentDetailByIdModel>>> getPaymentByPartyId(int? id) async {
    Uri url = _uri(Urls.baseUrl, Urls.getPartyAllPaymentById + '$id');
    try {
      http.Response response = await _client.get(url, headers: _restApiHeaders);
      final jsonResponse = jsonDecode(response.body);
      if (response.statusCode == HttpStatus.ok) {
        final paymentsById = <PaymentDetailByIdModel>[];
        if (jsonResponse['data'] != null) {
          for (final json in jsonResponse['data']) {
            paymentsById.add(PaymentDetailByIdModel.fromJson(json));
          }
        }
        return Data.fromResponse(response).copyWith(data: paymentsById);
      }
      return Data.fromJson(jsonResponse);
    } on SocketException catch (_) {
      return const Data(message: _noInternetConnection);
    } catch (e) {
      return const Data(message: _errorMessage);
    }
  }
}







