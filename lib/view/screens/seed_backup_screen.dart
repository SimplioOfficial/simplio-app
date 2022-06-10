import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simplio_app/logic/wallet_core_bloc/wallet_core_bloc.dart';

class SeedBackupScreen extends StatelessWidget {
  const SeedBackupScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _seed = context.read<WalletCoreBloc>().state.seed;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Seed'),
        backgroundColor: Colors.white,
        elevation: 1,
        foregroundColor: Colors.black87,
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
              'Wallet seed',
              key: Key('walletSeed'),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 16.0,
            ),
            child: BlocBuilder<WalletCoreBloc, WalletCoreState>(
              builder: (context, state) => InkWell(
                key: const Key('copy_seed'),
                onTap: () => Clipboard.setData(ClipboardData(text: _seed)),
                child: Text(
                  _seed,
                  style: const TextStyle(fontSize: 18, wordSpacing: 2.5),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
