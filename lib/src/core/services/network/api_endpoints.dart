const String _devUrl = 'http://192.168.100.6:3000';

const String baseUrl = _devUrl;

class ApiEndpoints {
  static const String _auth = '/auth';
  static const String login = '$_auth/login';
  static const String signUp = '$_auth/signup';
  static const String user = '$_auth/user';
}
