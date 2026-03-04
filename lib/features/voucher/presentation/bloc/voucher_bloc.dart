import 'package:flutter_assignment/features/voucher/data/repo/voucher_repo.dart';
import 'package:flutter_assignment/features/voucher/presentation/bloc/voucher_event.dart';
import 'package:flutter_assignment/features/voucher/presentation/bloc/voucher_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VoucherBloc extends Bloc<VoucherEvent, VoucherState> {
  final VoucherRepo repo;

  VoucherBloc(this.repo) : super(VoucherState(isLoading: true)) {
    on<LoadVoucher>(_onLoadVoucher);

    on<UpdateAmount>(_onUpdateAmount);

    on<ChangePaymentMethod>(_onChangeMethod);
  }

  Future<void> _onLoadVoucher(
    LoadVoucher event,
    Emitter<VoucherState> emit,
  ) async {
    try {
      emit(state.copyWith(loading: true));
      await Future.delayed(const Duration(seconds: 2));

      final voucher = await repo.fetchMockUser();

      // default method
      final defaultMethod = voucher.discounts.first.method;

      emit(
        state.copyWith(
          voucherModel: voucher,
          method: defaultMethod,
          loading: false,
        ),
      );

      _recalculate(emit);
    } catch (e) {
      emit(state.copyWith(loading: false));
    }
  }

  void _onUpdateAmount(UpdateAmount event, Emitter<VoucherState> emit) {
    emit(state.copyWith(amt: event.amount));

    _recalculate(emit);
  }

  void _onChangeMethod(ChangePaymentMethod event, Emitter<VoucherState> emit) {
    emit(state.copyWith(method: event.method));

    _recalculate(emit);
  }

  void _recalculate(Emitter<VoucherState> emit) {
    final voucher = state.voucherModel;

    if (voucher == null) return;

    final discount = voucher.discounts.firstWhere(
      (d) => d.method == state.selectedMethod,
      orElse: () => voucher.discounts.first,
    );

    final percent = discount.percent;
    final savings = state.selectedAmount * (percent / 100);

    final finalPrice = state.selectedAmount - savings;

    emit(state.copyWith(savings: savings, finalPrice: finalPrice));
  }
}
