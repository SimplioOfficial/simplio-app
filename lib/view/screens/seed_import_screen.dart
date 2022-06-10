import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simplio_app/logic/wallet_core_bloc/wallet_core_bloc.dart';
import 'package:simplio_app/view/widgets/next_button.dart';
import 'package:sio_core/sio_core.dart' as sio;

class SeedImportScreen extends StatefulWidget {
  const SeedImportScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SeedImportScreen();
}

class _SeedImportScreen extends State<SeedImportScreen> {
  String _seed = '';
  bool _isSeedValid = false;

  @override
  void initState() {
    _isSeedValid = sio.Mnemonic.isValid(mnemonic: _seed);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Import seed'),
        backgroundColor: Colors.white,
        elevation: 1,
        foregroundColor: Colors.black87,
      ),
      bottomNavigationBar: NextButton(
        isValid: _isSeedValid,
        text: 'Import',
        onPressed: () {
          context.read<WalletCoreBloc>().add(WalletCoreSeedSet(seed: _seed));

          Navigator.of(context).pop();
        },
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextField(
              key: const Key('seed_input'),
              onChanged: (value) {
                setState(() {
                  _seed = value;
                  _isSeedValid = sio.Mnemonic.isValid(mnemonic: _seed);
                });
              },
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: 'Import seed',
                errorText: _validateSeed ? null : 'Invalid seed',
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool get _validateSeed {
    return _isSeedValid || _seed.isEmpty;
  }
}
