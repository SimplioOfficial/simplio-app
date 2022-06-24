import 'package:flutter/material.dart';
import 'package:simplio_app/view/themes/common_theme.dart';

class AppBarSearch<T> extends StatelessWidget {
  final SearchDelegate<T> delegate;
  final String label;
  final Function(BuildContext context)? onTap;

  const AppBarSearch({
    super.key,
    required this.delegate,
    required this.label,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Material(
            color: Theme.of(context).colorScheme.primary,
            clipBehavior: Clip.hardEdge,
            shape: RoundedRectangleBorder(
              borderRadius: CommonTheme.borderRadius,
              side: BorderSide(
                width: 1,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
            child: InkWell(
              onTap: () {
                onTap?.call(context);
                showSearch(
                  context: context,
                  delegate: delegate,
                );
              },
              child: Container(
                alignment: Alignment.centerLeft,
                height: 42.0,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Icon(
                        Icons.search,
                        size: 18.0,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                    Text(label),
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
