class ApiEndPoints {

  static const String baseUrl = "http://192.168.4.3:3000";
  static const String googleLogin = 'users/google-login';
  static const String login = 'users/login';
  static const String signUp = 'users/register';
  static const String signUpOtp = 'users/registerVerify';
  static const String sendOtp = 'users/forgetPassword';
  static const String getWeather = 'weather/search?location=';
  static const String podcast = 'podcasts';
  static const String setHomeBase = 'weather/add-homebase';
  static const String getHomeBase = 'weather/get-homebase';
  static const String initializeUser = 'users/me';
}
