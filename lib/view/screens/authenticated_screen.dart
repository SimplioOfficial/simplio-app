import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simplio_app/l10n/localized_build_context_extension.dart';
import 'package:simplio_app/logic/tap_bar_cubit/tap_bar_cubit.dart';
import 'package:simplio_app/view/routes/authenticated_route.dart';
import 'package:simplio_app/view/routes/observers/tap_bar_observer.dart';
import 'package:simplio_app/view/widgets/tap_bar.dart';
import 'package:simplio_app/view/widgets/tap_bar_item.dart';

class AuthenticatedScreen extends StatefulWidget {
  final Key navigatorKey;
  final RouteFactory onGenerateRoute;
  final String initialRoute;

  const AuthenticatedScreen({
    super.key,
    required this.navigatorKey,
    required this.initialRoute,
    required this.onGenerateRoute,
  });

  @override
  State<AuthenticatedScreen> createState() => _AuthenticatedScreenState();
}

class _AuthenticatedScreenState extends State<AuthenticatedScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 300),
  );
  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: Offset.zero,
    end: const Offset(0, 1),
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.easeIn,
  ));

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TapBarCubit(),
      child: Builder(builder: (context) {
        return Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            Navigator(
              key: widget.navigatorKey,
              initialRoute: widget.initialRoute,
              onGenerateRoute: widget.onGenerateRoute,
              observers: [TapBarObserver.of(context)],
            ),
            BlocConsumer<TapBarCubit, TapBarState>(
              listenWhen: (previous, current) =>
                  previous.isDisplayed != current.isDisplayed,
              listener: (context, state) {
                if (state.isDisplayed) {
                  _controller.animateBack(0);
                } else {
                  _controller.animateTo(1);
                }
              },
              buildWhen: (previous, current) =>
                  previous.selectedItem != current.selectedItem,
              builder: (context, state) {
                return SlideTransition(
                  position: _offsetAnimation,
                  child: TapBar(
                    activeItem: state.selectedItem,
                    items: [
                      TapBarItem(
                          key: TabBarItemKeys.dashboard,
                          tapBarItemType: TapTabItemType.button,
                          icon: Icons.home_outlined,
                          activeIcon: Icons.home,
                          label: context.locale.homeTapBarLabel,
                          onTap: (context, key) {
                            AuthenticatedRoute.key.currentState
                                ?.pushReplacementNamed(AuthenticatedRoute.home);
                          }),
                      TapBarItem(
                          key: TabBarItemKeys.portfolio,
                          tapBarItemType: TapTabItemType.button,
                          icon: Icons.pie_chart_outline,
                          activeIcon: Icons.pie_chart,
                          label: context.locale.portfolioTapBarLabel,
                          onTap: (context, key) {
                            AuthenticatedRoute.key.currentState
                                ?.pushReplacementNamed(
                                    AuthenticatedRoute.portfolio);
                          }),
                      TapBarItem(tapBarItemType: TapTabItemType.spacer),
                      TapBarItem(
                          key: TabBarItemKeys.inventory,
                          tapBarItemType: TapTabItemType.button,
                          icon: Icons.sports_esports_outlined,
                          activeIcon: Icons.sports_esports,
                          label: context.locale.gamesTapBarLabel,
                          onTap: (context, key) {
                            AuthenticatedRoute.key.currentState
                                ?.pushReplacementNamed(
                                    AuthenticatedRoute.inventory);
                          }),
                      TapBarItem(
                          key: TabBarItemKeys.configuration,
                          tapBarItemType: TapTabItemType.button,
                          icon: Icons.settings_outlined,
                          activeIcon: Icons.settings,
                          label: context.locale.settingsTapBarLabel,
                          onTap: (context, key) {
                            AuthenticatedRoute.key.currentState
                                ?.pushReplacementNamed(
                                    AuthenticatedRoute.configuration);
                          }),
                    ],
                    height: 70.0,
                    floatingActionButtonOffset: 30,
                    floatingActionButton: FloatingActionButton(
                      child: const Icon(Icons.swap_calls),
                      onPressed: () {},
                    ),
                  ),
                );
              },
            ),
          ],
        );
      }),
    );
  }
}
