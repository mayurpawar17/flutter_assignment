import '../../data/voucher_model.dart';

class VoucherState {
  final VoucherModel? voucher;
  final int selectedAmount;
  final String selectedMethod;
  final bool isLoading;

  VoucherState({this.voucher, this.selectedAmount = 5000, this.selectedMethod = "UPI", this.isLoading = false});

  VoucherState copyWith({VoucherModel? v, int? amt, String? method, bool? loading}) {
    return VoucherState(
      voucher: v ?? voucher,
      selectedAmount: amt ?? selectedAmount,
      selectedMethod: method ?? selectedMethod,
      isLoading: loading ?? isLoading,
    );
  }
}