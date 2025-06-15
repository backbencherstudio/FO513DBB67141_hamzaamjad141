class DropdownState {
  final bool isExpanded;
  final String selectedItem;

  DropdownState({this.isExpanded = false, this.selectedItem = ''});

  DropdownState copyWith({bool? isExpanded, String? selectedItem}) {
    return DropdownState(
      isExpanded: isExpanded ?? this.isExpanded,
      selectedItem: selectedItem ?? this.selectedItem,
    );
  }
}