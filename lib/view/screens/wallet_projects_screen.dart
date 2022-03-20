import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simplio_app/data/model/wallet.dart';
import 'package:simplio_app/data/model/wallet_project.dart';
import 'package:simplio_app/logic/wallet/wallet_bloc.dart';
import 'package:simplio_app/view/widgets/project_toggle_item.dart';

class WalletProjectsScreen extends StatefulWidget {
  final List<WalletProject> supportedProjects;

  const WalletProjectsScreen({Key? key, this.supportedProjects = const []}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _WalletProjectScreen();
}

class _WalletProjectScreen extends State<WalletProjectsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
        ),
        backgroundColor: Colors.white,
        body: BlocBuilder<WalletBloc, WalletState>(
          builder: (context, state) => (state is Wallets)
              ? ListView.builder(
                  itemCount: widget.supportedProjects.length,
                  itemBuilder: (BuildContext ctx, int i) {
                    List<WalletProject> projects = widget.supportedProjects;
                    List<WalletProject> enabledProjects =
                        state.enabled().map((w) => w.project).toList();

                    return ProjectToggleItem(
                      toggled: enabledProjects.contains(projects[i]),
                      project: projects[i],
                      onToggle: (val, project) {
                        if (val) {
                          context.read<WalletBloc>().add(AddOrEnableWallet(
                              wallet: Wallet.generate(project: project)));
                        } else {
                          context
                              .read<WalletBloc>()
                              .add(DisableWallet(project: project));
                        }
                      },
                    );
                  },
                )
              : const Text('No wallets'),
        ));
  }
}