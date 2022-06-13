import 'package:flutter/material.dart';

class AppBarSearch<T> extends StatelessWidget {
  final SearchDelegate<T> delegate;
  final String label;
  final Function(BuildContext context)? onTap;

  const AppBarSearch({
    Key? key,
    required this.delegate,
    required this.label,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Material(
            clipBehavior: Clip.hardEdge,
            shape: RoundedRectangleBorder(
              borderRadius:
                  const BorderRadius.all(Radius.elliptical(100.0, 100.0)),
              side: BorderSide(
                width: 1,
                color: Theme.of(context).hoverColor,
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
                        color: Theme.of(context).unselectedWidgetColor,
                      ),
                    ),
                    Text(
                      label,
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Theme.of(context).unselectedWidgetColor,
                      ),
                    ),
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
