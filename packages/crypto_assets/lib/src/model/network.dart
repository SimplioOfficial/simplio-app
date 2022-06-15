class Network {
  final String url;
  final String? transactionUrl;
  final int coinType;
  final String name;

  const Network(
      {required this.url,
      required this.coinType,
      required this.name,
      this.transactionUrl});
}
