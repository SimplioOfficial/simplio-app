import 'package:flutter/material.dart';
import 'package:simplio_app/data/model/wallet_project.dart';

class ProjectToggleItem extends StatefulWidget {
  final WalletProject project;
  final void Function(bool, WalletProject)? onToggle;
  final bool toggled;

  const ProjectToggleItem(
      {Key? key, required this.project, this.toggled = false, this.onToggle})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _ProjectToggleItem();
}

class _ProjectToggleItem extends State<ProjectToggleItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 16.0,
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: widget.project.primaryColor,
              child: Icon(widget.project.icon, size: 18.0),
              foregroundColor: widget.project.foregroundColor,
            ),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.project.name, textScaleFactor: 1.2),
                        Opacity(
                            opacity: 0.4,
                            child: Text(widget.project.ticker.toUpperCase())),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Switch(
              value: widget.toggled,
              onChanged: (val) => widget.onToggle?.call(val, widget.project),
            ),
          ],
        ));
  }
}
