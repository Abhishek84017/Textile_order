class Validator {
  // Avoid creation of default constructor
  Validator._();

  // email pattern for regExp
  static const String emailPattern =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";

  // mobile pattern for regExp
  static const String mobilePattern = r"^(?:[+0]9)?[0-9]{10}$";

  // static const Pattern passwordPattern =
  //     r"/^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[^a-zA-Z0-9])(?!.*\s).{8,15}$/";

  // text with space pattern for regExp
  static const String textAllowedWithSpacePattern = r"^[a-zA-Z\s]+$";

  // address pattern for regExp
  static const String addressPattern = r"^[a-zA-Z0-9\s]+$";

  // pincode pattern for regExp
  static const String pinCodePattern = r"^[0-9]{6}$";

  // gst pattern for regExp
  static const String gstPattern =
      r"^[0-3]{1}[0-8]{1}[A-Z]{5}[0-9]{4}[A-Z]{1}[1-9A-Z]{1}Z[0-9A-Z]{1}$";

  // aadhaar pattern for regExp
  static const String aadhaarPattern = r"^[0-9]{12}$";

  // amount pattern for regExp
  static const String amountPattern = r"^[0-9]+[\.]?[0-9]{0,2}?$";

  // validate email
  static bool validateEmail(String email) {
    return RegExp(emailPattern).hasMatch(email);
  }

  // validate mobile number
  static bool validateMobile(String mobile) {
    return RegExp(mobilePattern).hasMatch(mobile);
  }

  // validate password
  static bool validatePassword(String password) {
    return password.length >= 8 && password.length <= 15;
    /* return RegExp(passwordPattern).hasMatch(password) &&
        password.length > 8 &&
        password.length < 15; */
  }

  // validate text with space only
  static bool validateTextWithSpace(String text) {
    return RegExp(textAllowedWithSpacePattern).hasMatch(text);
  }

  // validate pincode
  static bool validatePinCode(String pinCode) {
    return pinCode.isNotEmpty &&
        RegExp(pinCodePattern).hasMatch(pinCode) &&
        pinCode.length == 6;
  }

  // validate GST
  static bool validateGST(String gst) {
    return gst.isNotEmpty &&
        RegExp(gstPattern).hasMatch(gst) &&
        gst.length == 15;
  }

  // validate aadhaar
  static bool validateAadhaar(String aadhaar) {
    return aadhaar.isNotEmpty &&
        RegExp(aadhaarPattern).hasMatch(aadhaar) &&
        aadhaar.length == 12;
  }

  // validate address
  static bool validateAddress(String address) {
    return RegExp(addressPattern).hasMatch(address);
  }

  // validate amount
  static bool validateAmount(String amount) {
    return RegExp(amountPattern).hasMatch(amount);
  }
}
