import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final bottomSheetVisibilityProvider = StateProvider<bool>((ref) => false);

final navBarVisibilityProvider = Provider<bool>((ref) {
  final isBottomSheetVisible = ref.watch(bottomSheetVisibilityProvider);
  return !isBottomSheetVisible;
});


void showCustomBottomSheet(BuildContext context, WidgetRef ref, Widget content) {
  ref.read(bottomSheetVisibilityProvider.notifier).state = true;
  showModalBottomSheet(
    context: context,
    builder: (context) => content,
  ).whenComplete(() {
    ref.read(bottomSheetVisibilityProvider.notifier).state = false;
  });
}