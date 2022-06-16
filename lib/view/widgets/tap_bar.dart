import 'package:flutter/material.dart';
import 'package:simplio_app/view/widgets/tap_bar_item.dart';

class TapBar extends StatelessWidget {
  final List<TapBarItem> items;
  final FloatingActionButton? floatingActionButton;
  final double height;
  final double floatingActionButtonOffset;
  final double elevation;
  final int spacerRatio;
  final bool showLabel;
  final Key activeItem;

  const TapBar({
    super.key,
    required this.items,
    required this.activeItem,
    this.floatingActionButton,
    this.height = 56,
    this.floatingActionButtonOffset = 20,
    this.elevation = 20.0,
    this.spacerRatio = 2,
    this.showLabel = true,
  })  : assert(items.length <= 5),
        assert(floatingActionButtonOffset > 0);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      bottom: true,
      child: SizedBox(
        height: height + floatingActionButtonOffset,
        child: Stack(
          alignment: Alignment.bottomCenter,
          clipBehavior: Clip.none,
          children: [
            Container(
              height: height,
              decoration: BoxDecoration(
                color: theme.bottomNavigationBarTheme.backgroundColor,
                border: Border(
                  top: BorderSide(
                    width: 1,
                    color: theme.hoverColor,
                  ),
                ),
              ),
              child: Builder(
                builder: (context) {
                  return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: items.map((e) {
                        if (e.tapBarItemType == TapTabItemType.spacer) {
                          return Expanded(
                            key: UniqueKey(),
                            flex: 1,
                            child: Container(),
                          );
                        }

                        return Expanded(
                            key: e.key,
                            flex: spacerRatio,
                            child: _TapBarItem(
                              isActive: activeItem == e.key,
                              tapBarItem: e,
                            ));
                      }).toList());
                },
              ),
            ),
            if (floatingActionButton != null)
              Positioned(
                top: 0,
                child: floatingActionButton!,
              ),
          ],
        ),
      ),
    );
  }
}

class _TapBarItem extends StatelessWidget {
  final bool isActive;
  final TapBarItem tapBarItem;

  const _TapBarItem({
    required this.isActive,
    required this.tapBarItem,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final Color? selectedColor =
        theme.bottomNavigationBarTheme.selectedItemColor;
    final Color? unselectedColor =
        theme.bottomNavigationBarTheme.unselectedItemColor;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          tapBarItem.onTap?.call(context, tapBarItem.key!);
        },
        child: Center(
          child: isActive
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 2.0),
                      child: Icon(
                        tapBarItem.activeIcon,
                        color: selectedColor,
                      ),
                    ),
                    Text(
                      tapBarItem.label ?? '',
                      style: TextStyle(
                        fontSize: 12.0,
                        color: selectedColor,
                      ),
                    ),
                  ],
                )
              : Icon(
                  tapBarItem.icon,
                  color: unselectedColor,
                ),
        ),
      ),
    );
  }
}
