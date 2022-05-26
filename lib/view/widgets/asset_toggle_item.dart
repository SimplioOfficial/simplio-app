import 'package:crypto_assets/crypto_assets.dart';
import 'package:flutter/material.dart';

typedef AssetToggleAction = void Function({
  required bool value,
  required String assetId,
});

class AssetToggleItem extends StatefulWidget {
  final MapEntry<String, Asset> assetEntry;
  final bool toggled;
  final AssetToggleAction? onToggle;

  const AssetToggleItem({
    Key? key,
    required this.assetEntry,
    this.onToggle,
    this.toggled = false,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AssetToggleItem();
}

class _AssetToggleItem extends State<AssetToggleItem>
    with AutomaticKeepAliveClientMixin<AssetToggleItem> {
  late bool _toggled = widget.toggled;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final Asset asset = widget.assetEntry.value;

    return Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 16.0,
        ),
        child: Row(
          children: [
            CircleAvatar(
                foregroundColor: asset.detail.style.foregroundColor,
                backgroundColor: asset.detail.style.primaryColor,
                child: const Center()),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(asset.detail.name, textScaleFactor: 1.2),
                        Text(
                          asset.detail.ticker.toUpperCase(),
                          style: const TextStyle(color: Colors.black26),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Switch(
              value: _toggled,
              onChanged: (val) {
                widget.onToggle?.call(
                  value: val,
                  assetId: widget.assetEntry.key,
                );
                setState(() {
                  _toggled = !_toggled;
                });
              },
            ),
          ],
        ));
  }
}
