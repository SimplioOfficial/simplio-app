import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simplio_app/data/model/asset_wallet.dart';
import 'package:simplio_app/data/repositories/wallet_core_repository.dart';
import 'package:simplio_app/logic/wallet_utils.dart';
import 'package:simplio_app/view/routes/home_wallet_route.dart';
import 'package:trust_wallet_core_lib/trust_wallet_core_lib.dart';

class WalletSendScreen extends StatefulWidget {
  final AssetWallet assetWallet;

  const WalletSendScreen({Key? key, required this.assetWallet})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _WalletSendScreen();
}

class _WalletSendScreen extends State<WalletSendScreen> {
  String selectedNetwork = '';
  final _formKey = GlobalKey<FormState>();
  final amountController = TextEditingController();
  final addressController = TextEditingController();
  final feeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var walletCore = context.read<WalletCoreRepository>();

    List<Future<BigInt>> balance =
        widget.assetWallet.asset.assetTypes.map((assetType) async {
      return await WalletUtils.getBalance(
        network: assetType.network,
        address: walletCore.getAddress(assetType.network.coinType),
      );
    }).toList();

    return FutureBuilder<List<BigInt>>(
        future: Future.wait(balance),
        builder: (context, AsyncSnapshot<List<BigInt>> snapshot) {
          print('45 ${snapshot.data}');
          print('46 ${widget.assetWallet.asset.assetTypes.length}');

          return Scaffold(
            appBar: AppBar(
              title: const Text('Send'),
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              elevation: 0,
              // leading: IconButton(
              //   icon: const Icon(Icons.arrow_back_ios_new),
              //   onPressed: () => AppRoute.walletNav.currentState?.pop(),
              // ),
            ),
            backgroundColor: Colors.white,
            body: Form(
              key: _formKey,
              onChanged: () {
                _formKey.currentState!.validate();
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  ...widget.assetWallet.asset.assetTypes.map(
                    (type) => Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 16.0,
                      ),
                      child: Text(
                        'Network: ${type.network.name} - ${snapshot.data![widget.assetWallet.asset.assetTypes.indexOf(type)]} ${widget.assetWallet.asset.detail.ticker}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  // ListView.builder(
                  //   itemCount: snapshot.data?.length,
                  //   itemBuilder: (BuildContext ctx, int i) {
                  //     var assetType = widget.assetWallet.asset.assetTypes[i];
                  //
                  //     return Padding(
                  //       padding: const EdgeInsets.symmetric(
                  //         horizontal: 20.0,
                  //         vertical: 16.0,
                  //       ),
                  //       child: Text(
                  //         '${assetType.network.coinType} - ${balance[i]}',
                  //         style: const TextStyle(
                  //           fontSize: 20,
                  //           fontWeight: FontWeight.bold,
                  //         ),
                  //       ),
                  //     );
                  //   },
                  // ),

                  // Padding(
                  //   padding: const EdgeInsets.symmetric(
                  //     horizontal: 20.0,
                  //     vertical: 16.0,
                  //   ),
                  //   child: Text(
                  //     'Available amount: ${snapshot.data}',
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 16.0,
                    ),
                    child: TextFormField(
                      key: const Key('amount_input'),
                      controller: amountController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter number';
                        } else if (num.parse(value) >
                            (snapshot.data as List<BigInt>).first.toInt()) {
                          return 'Amount is greater than available amount';
                        }

                        return null;
                      },
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(r"^\d*\.?\d*$"),
                        )
                      ],
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Amount',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 16.0,
                    ),
                    child: TextFormField(
                      key: const Key('address_input'),
                      controller: addressController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter destination address';
                        } else if (AnyAddress.isValid(value,
                                widget.assetWallet.wallets.first.coinType) ==
                            false) {
                          return 'Enter correct address';
                        }

                        return null;
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Address',
                        errorText: null,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 16.0,
                    ),
                    child: TextFormField(
                      key: const Key('fee_input'),
                      controller: feeController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter number';
                        } else if (double.parse(value) +
                                (double.parse(amountController.text)) >
                            (snapshot.data as List<BigInt>).first.toInt()) {
                          return 'Fee and amount are greater than available '
                              'amount';
                        }

                        return null;
                      },
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(r"^\d*\.?\d*$"),
                        )
                      ],
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Fee',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 16.0,
                    ),
                    child: DropdownButtonFormField<String>(
                      value: selectedNetwork,
                      onChanged: (value) {
                        setState(() {
                          selectedNetwork = value ?? '';
                        });
                      },
                      items: widget.assetWallet.wallets.isNotEmpty
                          ? widget.assetWallet.wallets
                              .map(
                                (wallet) => DropdownMenuItem(
                                  child: Text(wallet.uuid),
                                  value: wallet.uuid,
                                ),
                              )
                              .toList()
                          : [],
                    ),
                  ),
                ],
              ),
            ),
            bottomSheet: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 16.0,
              ),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  key: const Key('send_button'),
                  child: const Text('Send'),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.of(context).pushNamed(HomeWalletRoute.send);
                    }
                    return;
                  },
                ),
              ),
            ),
          );
        });
  }
}
