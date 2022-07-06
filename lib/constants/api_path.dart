class Urls {
  // App's base url
  static const String baseUrl = 'www.textileutsav.com';

  // image path
  static String imagePath(String url) => 'https://$baseUrl/$url';

  // login endpoint
  static const String signIn = '/machine/api/check-login';

  //
  static const String getOrderStatusList = '/machine/api/get-order-list-status';

  //
  static const String getOrderRowStatusList =
      '/machine/api/get-order-row-list-status';

  //
  static const String getActiveOrders = '/machine/api/get-active-orders';

  static const String getPartyTotalPayment = '/machine/api/get-party-payment';


  static const String getPartyAllPaymentById = '/machine/api/get-party-payment-by-id/';

  //
  static String getOrderDetail(int orderId) =>
      'machine/api/get-order-details/$orderId';

  //
  static const String changeOrderStatus = '/machine/api/change-order-status';

  //
  static const String changeOrderRowStatus = '/machine/api/change-order-row-status';

  static const String galleryCategory = 'https://www.textileutsav.com/machine/api/get-gallery-category';

  static const String allFirms = 'http://www.textileutsav.com/machine/api/get-all-firm';
}
