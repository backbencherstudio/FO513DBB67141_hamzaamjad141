import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../riverpod/parent_notifier.dart';

class ParentScreen extends StatelessWidget{
  const ParentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(),
      body: Consumer(
        builder: (_, ref, _) {
          final parentState = ref.watch(parentProvider);
          final parentNotifier = ref.read(parentProvider.notifier);
          return IndexedStack(
            index: parentState.selectedIndex,
            children: parentNotifier.pageList,
          );
        }
      ),
    );
  }
}