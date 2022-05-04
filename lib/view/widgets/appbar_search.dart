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
            color: const Color.fromRGBO(241, 241, 241, 1.0),
            clipBehavior: Clip.hardEdge,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.elliptical(100.0, 100.0)),
              side: BorderSide(
                  color: Color.fromRGBO(231, 231, 231, 1.0), width: 1),
            ),
            child: InkWell(
              onTap: () {
                onTap!(context);
                showSearch(
                  context: context,
                  delegate: delegate,
                );
              },
              splashColor: const Color.fromRGBO(0, 0, 0, 0.06),
              highlightColor: const Color.fromRGBO(0, 0, 0, 0.04),
              child: Container(
                alignment: Alignment.centerLeft,
                height: 36.0,
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Icon(
                        Icons.search,
                        size: 16.0,
                        color: Colors.black45,
                      ),
                    ),
                    Text(
                      label,
                      style: const TextStyle(
                          fontSize: 14.0, color: Colors.black45),
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
