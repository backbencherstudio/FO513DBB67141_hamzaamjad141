class ApiEndPoints {

  // static const String baseUrl = "http://192.168.4.35:3000";
  
  static const String baseUrl = "https://api.leftseatlessons.com";
  
  static const String googleLogin = 'users/google-login';
  static const String login = 'users/login';
  static const String signUp = 'users/register';
  static const String signUpOtp = 'users/registerVerify';
  static const String sendOtp = 'users/forgetPassword';
  
  //static const String podcast = '$baseUrl/podcasts';
  
  static const String getWeather = 'weather/search?location=';
  static const String podcast = 'podcasts';
  static const String setHomeBase = 'weather/add-homebase';
  static const String getHomeBase = 'weather/get-homebase';
  static const String initializeUser = 'users/me';
  static const String forgetOtp = 'users/verify-top';
  static const String resetpass = 'users/change-password';
  static const String addToFavoriteWeather = 'weather/add-favourite';
  static const String getFavouriteWeatherList = 'weather/get-favourite?page=1&item=10';
  static const String createInstructor = "instructor/create-by-user";
  static const String setInstructor = "instructor/set-instructor/";
  static const String getInstructor = "instructor/my-instructor";
  static const String addLogBook = "addlog/add-addlog";
  static const String getLogRequestList = "addlog/get-logbook?page=1&limit=100";
  static const String deleteLogRequest = 'addlog/delete-log/';
  static const String payment = 'subscription/pay';
  static const String promoCode = 'subscription/subscribe-with-promo';
  static const String logBookSummary = 'addlog/get-logsummary';
  static const String editProfile = 'users/update-user';
  static const String resendOtp = 'users/resent-otp';
}
