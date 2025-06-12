import 'package:flutter/material.dart';
import 'package:aviation_app/features/parent_screen/riverpod/parent_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final parentProvider =
    StateNotifierProvider<ParentsScreenProvider, ParentState>((ref) {
      return ParentsScreenProvider();
    });

class ParentsScreenProvider extends StateNotifier<ParentState> {
  ParentsScreenProvider() : super(const ParentState());

  final List<Widget> _pageList = [];

  List<Widget> get pageList => _pageList;

  void onSelectedIndex(int index) {
    debugPrint("Selected Page index : $index");
    state = state.copyWith(selectedIndex: index);
  }
}
