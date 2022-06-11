import 'package:http/http.dart';

/// Global class to store data
/// and paginated products fetched from RestApi
/// and the type of data will be the parameter type of class

class Data<T> {
  final int? statusCode;
  final String? message;
  final T? data;
  final PaginationModel? pagination;

  const Data({
    this.message = 'Data not found',
    this.data,
    this.statusCode = 204,
    this.pagination,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    T? _data;
    if (json['status'] == "true") {
      _data = json['data'];
    }
    String? _message = '';
    if (json['message'] is String) {
      _message = json['message'];
    } else if (json['message'] is Map) {
      if (json['message'].entries.first.value is List) {
        _message = '${json['message'].entries.first.value.first}';
      }
    } else {
      _message = json['message']?.toString();
    }
    return Data<T>(
      statusCode: json['status'] == "true" ? 200 : 204,
      message: _message,
      data: _data,
      pagination: const PaginationModel(),
    );
  }

  /// Data model from Response
  factory Data.fromResponse(Response response) {
    return Data(
      statusCode: response.statusCode,
      message: response.reasonPhrase,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': statusCode,
      'message': message,
      'data': data,
    };
  }

  // Copy with existing data
  Data<T> copyWith<T>({
    int? statusCode,
    String? message,
    T? data,
    PaginationModel? pagination,
  }) =>
      Data<T>(
        data: data ?? (this.data as T),
        message: message ?? this.message,
        pagination: pagination ?? this.pagination,
        statusCode: statusCode ?? this.statusCode,
      );
}

class PaginationModel {
  const PaginationModel();

  factory PaginationModel.fromJson(Map<String, dynamic> json) =>
      const PaginationModel();
}
