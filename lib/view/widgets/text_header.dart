import 'package:flutter/material.dart';

class TextHeader extends StatelessWidget {
  final String title;
  final String subtitle;

  const TextHeader({
    super.key,
    this.title = '',
    this.subtitle = '',
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if (title.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: 6.0),
                child: Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 24.0,
                  ),
                ),
              ),
            if (subtitle.isNotEmpty) Text(subtitle),
          ],
        ),
      ],
    );
  }
}
