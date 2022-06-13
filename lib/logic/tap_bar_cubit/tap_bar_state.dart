part of './tap_bar_cubit.dart';

class TapBarState extends Equatable {
  final bool isDisplayed;
  final Key selectedItem;

  const TapBarState._({
    required this.isDisplayed,
    required this.selectedItem,
  });

  const TapBarState.init()
      : this._(
          isDisplayed: false,
          selectedItem: TabBarItemKeys.dashboard,
        );

  @override
  List<Object?> get props => [
        isDisplayed,
        selectedItem,
      ];

  TapBarState copyWith({
    bool? isDisplayed,
    Key? selectedItem,
  }) {
    return TapBarState._(
      isDisplayed: isDisplayed ?? this.isDisplayed,
      selectedItem: selectedItem ?? this.selectedItem,
    );
  }
}
