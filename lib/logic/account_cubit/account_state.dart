part of 'account_cubit.dart';

class AccountState extends Equatable {
  final Account? account;
  final List<AssetWallet> assetWallets;

  const AccountState._({
    required this.account,
    required this.assetWallets,
  });

  const AccountState.initial() : this._(account: null, assetWallets: const []);

  const AccountState.value({
    required Account? account,
    required List<AssetWallet> assetWallets,
  }) : this._(account: account, assetWallets: assetWallets);

  @override
  List<Object?> get props => [account, assetWallets, account?.settings.locale];

  List<AssetWallet> get enabledAssetWallets =>
      assetWallets.where((element) => element.isEnabled).toList();

  AccountState copyWith({
    Account? account,
    List<AssetWallet>? assetWallets,
  }) {
    return AccountState.value(
      account: account ?? this.account,
      assetWallets: assetWallets ?? this.assetWallets,
    );
  }
}
