import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simplio_app/logic/trust_wallet_core_bloc/trust_wallet_core_bloc.dart';
import 'package:simplio_app/view/routes/app_route.dart';
import 'package:simplio_app/view/widgets/next_button.dart';
import 'package:sio_core/sio_core.dart' as sio;

class ManualSeedImportScreen extends StatefulWidget {
  const ManualSeedImportScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ManualSeedImportScreen();
}

class _ManualSeedImportScreen extends State<ManualSeedImportScreen> {
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
        automaticallyImplyLeading: false,
        title: const Text('Seed'),
        backgroundColor: Colors.white,
        elevation: 1,
        foregroundColor: Colors.black87,
      ),
      bottomNavigationBar: NextButton(
        isValid: _isSeedValid,
        onPressed: () {
          var wallet = sio.Mnemonic.import(mnemonic: _seed);
          context
              .read<TrustWalletCoreBloc>()
              .add(TrustWalletCoreSet(trustWallet: wallet));

          Navigator.of(context, rootNavigator: true)
              .popAndPushNamed(AppRoute.home);
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
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
            ),
            child: Align(
              alignment: Alignment.topRight,
              child: TextButton(
                key: const Key('manual_seed_import_button'),
                onPressed: () {
                  setState(() {
                    _isSeedValid = sio.Mnemonic.isValid(mnemonic: _seed);
                  });
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Show generated seed',
                  style: TextStyle(fontSize: 16, color: Colors.blue),
                ),
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
