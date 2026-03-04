import 'package:equatable/equatable.dart';

abstract class VoucherEvent extends Equatable {}

class LoadVoucher extends VoucherEvent {
  @override
  List<Object?> get props => [];
}

class UpdateAmount extends VoucherEvent {
  final int amount;

  UpdateAmount(this.amount);

  @override
  List<Object?> get props => [amount];
}

class ChangePaymentMethod extends VoucherEvent {
  final String method;

  ChangePaymentMethod(this.method);

  @override
  List<Object?> get props => [method];
}
