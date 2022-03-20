import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simplio_app/config/projects.dart';
import 'package:simplio_app/data/model/wallet.dart';
import 'package:simplio_app/data/model/wallet_project.dart';
import 'package:simplio_app/logic/wallet/wallet_bloc.dart';
import 'package:simplio_app/view/widgets/project_toggle_item.dart';

class WalletsScreen extends StatefulWidget {
  const WalletsScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _WalletsScreen();
}

class _WalletsScreen extends State<WalletsScreen> {
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
                  itemCount: Projects().supported.length,
                  itemBuilder: (BuildContext ctx, int i) {
                    List<WalletProject> projects = Projects().supported;
                    List<WalletProject> activeProjects =
                        state.active().map((w) => w.project).toList();

                    return ProjectToggleItem(
                      toggled: activeProjects.contains(projects[i]),
                      project: projects[i],
                      onToggle: (val, project) {
                        if (val) {
                          context.read<WalletBloc>().add(AddOrActivateWallet(
                              wallet: Wallet.generate(project: project)));
                        } else {
                          context
                              .read<WalletBloc>()
                              .add(DeactivateProject(project: project));
                        }
                      },
                    );
                  },
                )
              : const Text('No wallets'),
        ));
  }
}