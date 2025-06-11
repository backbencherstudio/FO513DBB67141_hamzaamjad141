
class ParentState {
  final int selectedIndex;

  const ParentState({
    this.selectedIndex = 0,
  });

  ParentState copyWith({int? selectedIndex}) {
    return ParentState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
    );
  }
}