import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simplio_app/logic/bloc_providers.dart';
import 'package:simplio_app/logic/trust_wallet_core_bloc/trust_wallet_core_bloc.dart';
import 'package:simplio_app/view/router/app_router.dart';
import 'package:sio_core/sio_core.dart' as sio;

class GenerateSeedScreen extends StatefulWidget {
  const GenerateSeedScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _GenerateSeedScreen();
}

class _GenerateSeedScreen extends State<GenerateSeedScreen> {
  static const String generateSeed = '/';
  static const String manualSeedImport = '/import';

  String _seed = sio.Mnemonic().generate;
  late final String _generatedSeed;
  bool _isSeedValid = false;

  @override
  void initState() {
    _isSeedValid = sio.Mnemonic.isValid(mnemonic: _seed);
    _generatedSeed = _seed;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case generateSeed:
            return MaterialPageRoute(
              builder: (context) => BlocProvider(
                create: (context) => BlocProviders.trustWalletCoreBloc,
                child: _generateSeedWidget(),
              ),
            );
          case manualSeedImport:
            return MaterialPageRoute(
              builder: (context) => BlocProvider.value(
                value: BlocProviders.trustWalletCoreBloc,
                child: _manualSeedImportWidget(),
              ),
            );
          default:
            throw const FormatException('Screen not found');
        }
      },
    );
  }

  Widget _generateSeedWidget() {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _appBar(),
      bottomNavigationBar: _bottomNavigationBar(),
      body: BlocBuilder<TrustWalletCoreBloc, TrustWalletCoreState>(
        builder: (context, state) {
          return Column(
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
                      setState(() {
                        _seed = '';
                        _isSeedValid = false;
                      });
                      var wallet =
                          sio.Mnemonic.import(mnemonic: _generatedSeed);
                      context
                          .read<TrustWalletCoreBloc>()
                          .add(TrustWalletCoreSet(trustWallet: wallet));

                      Navigator.of(context).pushNamed(manualSeedImport);
                    },
                    child: const Text(
                      'Import recovery seed',
                      style: TextStyle(fontSize: 16, color: Colors.blue),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _manualSeedImportWidget() {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _appBar(),
      bottomNavigationBar: _bottomNavigationBar(),
      body: BlocBuilder<TrustWalletCoreBloc, TrustWalletCoreState>(
        builder: (context, state) => Column(
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
                      _seed = _generatedSeed;
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

  Widget _bottomNavigationBar() {
    return BlocBuilder<TrustWalletCoreBloc, TrustWalletCoreState>(
        builder: (context, state) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
        child: ElevatedButton(
          key: const Key('seed_import_button'),
          child: const Text('Next'),
          onPressed: _isSeedValid
              ? () {
                  var wallet = sio.Mnemonic.import(mnemonic: _seed);
                  context
                      .read<TrustWalletCoreBloc>()
                      .add(TrustWalletCoreSet(trustWallet: wallet));

                  Navigator.of(context, rootNavigator: true)
                      .popAndPushNamed(AppRouter.home);
                }
              : null,
        ),
      );
    });
  }

  bool get _validateSeed {
    return _isSeedValid || _seed.isEmpty;
  }
}
