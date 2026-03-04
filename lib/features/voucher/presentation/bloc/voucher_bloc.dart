import 'package:flutter_assignment/features/voucher/presentation/bloc/voucher_event.dart';
import 'package:flutter_assignment/features/voucher/presentation/bloc/voucher_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/voucher_model.dart';

class VoucherBloc extends Bloc<VoucherEvent, VoucherState> {
  VoucherBloc() : super(VoucherState(isLoading: true)) {
    on<LoadVoucher>((event, emit) async {
      // Simulating API Call
      await Future.delayed(const Duration(seconds: 1));
      final mockJson = {
        "id": "zepto-100",
        "title": "Zepto Instant Voucher",
        "minAmount": 50,
        "maxAmount": 10000,
        "disablePurchase": false,
        "discounts": [
          {"method": "UPI", "percent": 4},
          {"method": "CARD", "percent": 4},
        ],
        "redeemSteps": [
          "Login to Zepto Platform",
          "Click on My profile / Settings",
          "Go to Zepto Cash & Gift Card",
          "Click on Add Card option",
        ],
      };
      emit(state.copyWith(v: VoucherModel.fromJson(mockJson), loading: false));
    });

    on<UpdateAmount>((event, emit) => emit(state.copyWith(amt: event.amount)));
    on<ChangePaymentMethod>(
      (event, emit) => emit(state.copyWith(method: event.method)),
    );
  }
}
