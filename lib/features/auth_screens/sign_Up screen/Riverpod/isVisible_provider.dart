import 'package:flutter_riverpod/flutter_riverpod.dart';

final isLoginVisibleProvider = StateNotifierProvider< LoginNotifier, bool>((ref)=> LoginNotifier());
class LoginNotifier extends StateNotifier<bool>{
  LoginNotifier():super(false);
  void onTapToggle(){
  state = !state;
  }
}

final isPassVisibleProvider = StateNotifierProvider< LoginOneNotifier, bool>((ref)=> LoginOneNotifier());
class LoginOneNotifier extends StateNotifier<bool>{
  LoginOneNotifier():super(false);
  void onTapToggle(){
  state = !state;
  }
}

final isConfirmPAssVisibleProvider = StateNotifierProvider< LoginTwoNotifier, bool>((ref)=> LoginTwoNotifier());
class LoginTwoNotifier extends StateNotifier<bool>{
  LoginTwoNotifier():super(false);
  void onTapToggle(){
  state = !state;
  }
}