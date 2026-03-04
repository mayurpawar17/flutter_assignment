import 'package:equatable/equatable.dart';

import '../../data/model/voucher_model.dart';

class VoucherState extends Equatable {
  final bool isLoading;
  final VoucherModel? voucherModel;

  final int selectedAmount;
  final String selectedMethod;

  final double finalPrice;
  final double savings;

  const VoucherState({
    this.isLoading = false,
    this.voucherModel,
    this.selectedAmount = 0,
    this.selectedMethod = 'UPI',

    this.finalPrice = 0,
    this.savings = 0,
  });

  VoucherState copyWith({
    bool? loading,
    VoucherModel? voucherModel,

    int? amt,
    String? method,

    double? finalPrice,
    double? savings,
  }) {
    return VoucherState(
      isLoading: loading ?? isLoading,
      voucherModel: voucherModel ?? this.voucherModel,

      selectedAmount: amt ?? selectedAmount,
      selectedMethod: method ?? selectedMethod,

      finalPrice: finalPrice ?? this.finalPrice,
      savings: savings ?? this.savings,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    voucherModel,
    selectedAmount,
    selectedMethod,
    finalPrice,
    savings,
  ];
}
