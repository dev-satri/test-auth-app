const String _devUrl = 'http://192.168.1.73:3000';

const String baseUrl = _devUrl;

class ApiEndpoints {
  ///Auth
  static const String _auth = '/auth';
  static const String login = '$_auth/login';
  static const String signUp = '$_auth/signup';
  static const String user = '$_auth/user';

  ///Product
  static const String _product = '/product';
  static const String allProducts = '$_product/all-product';
}
