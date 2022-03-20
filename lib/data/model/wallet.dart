import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class Wallet extends Equatable {
  final Uuid uuid;
  final String name;
  final String ticker;

  const Wallet(this.uuid, this.name, this.ticker);

  const Wallet.generate({required String name, required String ticker})
      : this(const Uuid(), name, ticker);

  @override
  List<Object?> get props => [uuid, name, ticker];

  Wallet copyWith({String? name, String? ticker}) {
    return Wallet(
      uuid,
      name ?? this.name,
      ticker ?? this.ticker,
    );
  }
}