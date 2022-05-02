import 'package:flutter/material.dart';

class AppBarSearch<T> extends StatelessWidget {
  final SearchDelegate<T> delegate;
  final String label;

  const AppBarSearch(
      {Key? key, required this.delegate, required this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: GestureDetector(
          onTap: () => showSearch(
            context: context,
            delegate: delegate,
          ),
          child: Container(
            alignment: Alignment.centerLeft,
            height: 36.0,
            decoration: BoxDecoration(
              color: const Color.fromRGBO(241, 241, 241, 1.0),
              border:
                  Border.all(color: const Color.fromRGBO(231, 231, 231, 1.0)),
              borderRadius:
                  const BorderRadius.all(Radius.elliptical(100.0, 100.0)),
            ),
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
                  style: const TextStyle(fontSize: 14.0, color: Colors.black45),
                ),
              ],
            ),
          ),
        ))
      ],
    );
  }
}
