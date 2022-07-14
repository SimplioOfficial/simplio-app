import 'package:flutter/material.dart';
import 'package:simplio_app/view/themes/common_theme.dart';
import 'package:simplio_app/view/widgets/themed_linear_progress_indicator.dart';

class Story extends StatefulWidget {
  final List<Widget> items;
  final Widget? bottomNavigationBar;
  final Duration itemDuration;
  final bool repeat;

  final double _indicatorPadding = 15;

  const Story({
    super.key,
    required this.items,
    this.itemDuration = const Duration(seconds: 3),
    this.repeat = false,
    this.bottomNavigationBar,
  });

  @override
  State<Story> createState() => _StoryState();
}

class _StoryState extends State<Story> with TickerProviderStateMixin {
  late List<AnimationController> controllers;
  int displayedItemIndex = 0;

  @override
  Widget build(BuildContext context) {
    var bars = Padding(
      padding: CommonTheme.horizontalPadding,
      child: Row(
        children: widget.items
            .asMap()
            .entries
            .map(
              (e) => Padding(
                padding: _progressIndicatorPadding(e.key, widget.items.length),
                child: SizedBox(
                  width: _indicatorWidth(),
                  child: ThemedLinearProgressIndicator(
                    value: controllers[e.key].value,
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );

    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: CommonTheme.bottomPadding,
            child: bars,
          ),
          Expanded(
            child: GestureDetector(
              onTapDown: (_) => _toggleAnimation(),
              onLongPressEnd: (_) => _toggleAnimation(stop: false),
              onTapUp: (details) => _handleLeftRightTaps(details),
              child: Padding(
                padding: CommonTheme.bottomPadding
                    .add(CommonTheme.horizontalPadding),
                child: widget.items[displayedItemIndex],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: widget.bottomNavigationBar,
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    controllers = widget.items
        .asMap()
        .entries
        .map(
          (e) => AnimationController(
            vsync: this,
            duration: widget.itemDuration,
            animationBehavior: AnimationBehavior.preserve,
          )
            ..addListener(() => setState(() => displayedItemIndex = e.key))
            ..addStatusListener((AnimationStatus status) {
              if (status == AnimationStatus.completed) {
                if (e.key + 1 < widget.items.length) {
                  controllers[e.key + 1].forward();
                }

                if (widget.repeat && e.key + 1 == widget.items.length) {
                  _resetProgressBars();
                  controllers.first.forward(from: 0);
                }
              }
            }),
        )
        .toList();
    controllers.first.forward();
    super.initState();
  }

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  EdgeInsetsGeometry _progressIndicatorPadding(int index, int length) {
    if (index + 1 < length) {
      return EdgeInsets.only(right: widget._indicatorPadding);
    } else {
      return const EdgeInsets.only();
    }
  }

  double _indicatorWidth() {
    return (MediaQuery.of(context).size.width -
            CommonTheme.horizontalPadding.horizontal -
            widget._indicatorPadding * (widget.items.length - 1)) /
        widget.items.length;
  }

  void _toggleAnimation({stop = true}) {
    stop
        ? controllers[displayedItemIndex].stop()
        : controllers[displayedItemIndex].forward();
  }

  void _resetProgressBars() {
    for (var controller in controllers) {
      controller.stop();
      controller.value = 0;
    }
  }

  void _handleLeftRightTaps(TapUpDetails details) {
    bool rightTap =
        details.globalPosition.dx > MediaQuery.of(context).size.width / 2;

    if (rightTap) {
      if (displayedItemIndex + 1 < widget.items.length) {
        controllers[displayedItemIndex].value = 1;
        controllers[displayedItemIndex + 1].forward();
        setState(() => displayedItemIndex += 1);
      } else {
        _resetProgressBars();
        controllers[0].forward();
        setState(() => displayedItemIndex = 0);
      }
    } else {
      if (displayedItemIndex > 0) {
        controllers[displayedItemIndex].value = 0;
        controllers[displayedItemIndex - 1].forward(from: 0);
        setState(() => displayedItemIndex -= 1);
      } else {
        controllers[0].stop();
        for (var controller in controllers) {
          controller.value = 1;
        }
      }
    }
  }
}
