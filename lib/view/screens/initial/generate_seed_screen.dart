import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simplio_app/logic/trust_wallet_core_bloc/trust_wallet_core_bloc.dart';
import 'package:simplio_app/view/routes/app_route.dart';
import 'package:simplio_app/view/routes/home_initial_route.dart';
import 'package:simplio_app/view/routes/home_route.dart';
import 'package:simplio_app/view/widgets/next_button.dart';
import 'package:sio_core/sio_core.dart' as sio;

class GenerateSeedScreen extends StatefulWidget {
  const GenerateSeedScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _GenerateSeedScreen();
}

class _GenerateSeedScreen extends State<GenerateSeedScreen> {
  final String _seed = sio.Mnemonic().generate;
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
      appBar: _appBar(),
      bottomNavigationBar: NextButton(
        isValid: _isSeedValid,
        onPressed: () {
          var wallet = sio.Mnemonic.import(mnemonic: _seed);
          context
              .read<TrustWalletCoreBloc>()
              .add(TrustWalletCoreSet(trustWallet: wallet));

          // Navigator.of(context).pop();
          // AppRoute.mainAppNav.currentState!.pop();
          AppRoute.authGuardNav.currentState?.pop();
        },
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 16.0,
            ),
            child: Text(
              'Generated seed',
              key: Key('generatedSeed'),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 16.0,
            ),
            child: InkWell(
              key: const Key('copy_seed'),
              onTap: () => Clipboard.setData(ClipboardData(text: _seed)),
              child: Text(
                _seed,
                style: const TextStyle(fontSize: 18, wordSpacing: 2.5),
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
                key: const Key('manual_seed_import'),
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(HomeInitialRoute.manualSeedImport);
                },
                child: const Text(
                  'Import recovery seed',
                  style: TextStyle(fontSize: 16, color: Colors.blue),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _appBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      title: const Text('Seed'),
      backgroundColor: Colors.white,
      elevation: 1,
      foregroundColor: Colors.black87,
    );
  }
}
