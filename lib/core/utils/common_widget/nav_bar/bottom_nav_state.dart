import 'package:flutter_riverpod/flutter_riverpod.dart';

class BottomNavState {
  final bool isBottomSheetOpen;

  BottomNavState({required this.isBottomSheetOpen});
}

class BottomNavNotifier extends StateNotifier<BottomNavState> {
  BottomNavNotifier() : super(BottomNavState(isBottomSheetOpen: false));

  void showBottomSheet() {
    state = BottomNavState(isBottomSheetOpen: true);
  }

  void hideBottomSheet() {
    state = BottomNavState(isBottomSheetOpen: false);
  }
}

final bottomNavProvider =
    StateNotifierProvider<BottomNavNotifier, BottomNavState>((ref) {
      return BottomNavNotifier();
    });
