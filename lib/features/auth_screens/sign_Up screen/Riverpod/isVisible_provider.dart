import 'package:flutter_riverpod/flutter_riverpod.dart';

final isLoginVisibleProvider = StateNotifierProvider< LoginNotifier, bool>((ref)=> LoginNotifier());
class LoginNotifier extends StateNotifier<bool>{
  LoginNotifier():super(false);
  void onTapToggle(){
  state = !state;
  }
}
