// import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
// import 'package:flutter/material.dart';
// import 'package:pal_shopie/config/router/router.dart';
// import 'package:pal_shopie/constants/api_path.dart';
// import 'package:pal_shopie/constants/app_constants.dart';
// import 'package:pal_shopie/models/models.dart';
// import 'package:pal_shopie/screens/auth/sign_up/sign_up.dart';
// import 'package:pal_shopie/screens/product_details/product_details.dart';
//
// class DynamicLinkService {
//   static Future handleDynamicLinks(BuildContext context) async {
//     final PendingDynamicLinkData data =
//         await FirebaseDynamicLinks.instance.getInitialLink();
//     _handleDeepLinkData(data, context: context);
//
//     // FirebaseDynamicLinks.instance.onLink(
//     //     onSuccess: (data) => _onDeepLinkSuccess(data, context),
//     //     onError: (error) => _onDeepLinkError(error));
//   }
//
//   static void _handleDeepLinkData(PendingDynamicLinkData data,
//       {BuildContext context}) async {
//     final Uri deepLink = data?.link;
//     if (deepLink != null) {
//       if (deepLink.path == '/product') {
//         if (data.link.queryParameters.containsKey('productId')) {
//           if (kBranchProvider.id != data.link.queryParameters['id']) {
//             await kBranchProvider
//                 .setBranch(BranchModel.fromJson(data.link.queryParameters));
//           }
//           /*
//           * Uncomment below given line for branches
//           * */
//           // kHomeState.refresh();
//         }
//         Navigate.to(
//             ProductDetails(productId: data.link.queryParameters['productId']));
//       }
//       if (deepLink.path == '/referrer' && kUserProvider?.user == null) {
//         Navigate.to(
//           const SignUp(),
//           settings: RouteSettings(
//             arguments: data.link.queryParameters['code'],
//           ),
//         );
//       }
//     }
//   }
//
//   /*static Future _onDeepLinkSuccess(
//       PendingDynamicLinkData linkData, BuildContext context) async {
//     _handleDeepLinkData(linkData, context: context);
//     return;
//   }
//
//   static Future _onDeepLinkError(OnLinkErrorException error) async {
//     // print('Dynamic link error occurred $error');
//     return;
//   }*/
//
//   static Future<Uri> createDynamicLinkForProduct(
//       ProductModel productDetail) async {
//     Map<String, dynamic> queryParameters = {'productId': productDetail.id};
//     /*
//     * Uncomment below given line for branches
//     * */
//     // queryParameters.addAll(kBranchProvider.branch.toJson());
//     final DynamicLinkParameters parameters = DynamicLinkParameters(
//       uriPrefix: 'https://palgeneralstore.page.link',
//       link: Uri(
//         scheme: 'https',
//         host: 'palshopie.com',
//         path: '/product',
//         queryParameters: queryParameters,
//       ),
//       // link: Uri.parse(
//       //     'https://palshopie.com/product?product_id=${productDetail.id}&branch_code=${productDetail.branchCode}'),
//       androidParameters: const AndroidParameters(
//         packageName: 'com.palgeneralstore.pal_shopie',
//         minimumVersion: 0,
//       ),
//       // dynamicLinkParametersOptions: DynamicLinkParametersOptions(
//       //   shortDynamicLinkPathLength: ShortDynamicLinkPathLength.short,
//       // ),
//       socialMetaTagParameters: SocialMetaTagParameters(
//         title: productDetail.name,
//         description: productDetail.shortDesc,
//         imageUrl: Uri.parse(Urls.imagePath(productDetail.imagePath)),
//       ),
//     );
//     return parameters.link;
//   }
//
//   static Future<Uri> createDynamicLinkForReferrer(String referrerCode) async {
//     final DynamicLinkParameters parameters = DynamicLinkParameters(
//       uriPrefix: 'https://palgeneralstore.page.link',
//       link: Uri.parse('https://palshopie.com/referrer?code=$referrerCode'),
//       androidParameters: const AndroidParameters(
//         packageName: 'com.palgeneralstore.pal_shopie',
//         minimumVersion: 0,
//       ),
//       // dynamicLinkParametersOptions: DynamicLinkParametersOptions(
//       //   shortDynamicLinkPathLength: ShortDynamicLinkPathLength.short,
//       // ),
//       socialMetaTagParameters: SocialMetaTagParameters(
//         title: kAppName,
//         description: 'Sign up with Pal Shopie and get exciting rewards',
//         imageUrl: Uri.parse(
//           'https://mentorship.optimizeias.com/images/refer_earn.png',
//         ),
//       ),
//     );
//     return parameters.link;
//   }
// }
