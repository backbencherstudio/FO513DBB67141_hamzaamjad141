import 'package:aviation_app/features/auth_screens/sign_Up%20screen/Riverpod/dropdown_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dropdownProvider = StateNotifierProvider<DropdownNotifier, DropdownState>((ref) {
  return DropdownNotifier();
});



class DropdownNotifier extends StateNotifier<DropdownState> {
  DropdownNotifier() : super(DropdownState());

  void toggleExpansion() {
    state = state.copyWith(isExpanded: !state.isExpanded);
  }

  void selectItem(String item) {
    state = state.copyWith(selectedItem: item, isExpanded: false);
  }
}

