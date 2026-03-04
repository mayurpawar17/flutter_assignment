import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repo/voucher_repo.dart';
import '../bloc/voucher_bloc.dart';
import '../bloc/voucher_event.dart';
import '../bloc/voucher_state.dart';

class VoucherScreen extends StatelessWidget {
  const VoucherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => VoucherBloc(VoucherRepo())..add(LoadVoucher()),

      child: Scaffold(
        backgroundColor: const Color(0xFFF8FAFC),

        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          surfaceTintColor: Colors.transparent,

          title: const Text(
            "Purchase Voucher",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),

          actions: [
            OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.share, size: 18),
              label: const Text("Refer & Earn ₹500"),

              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.blueAccent,
                side: const BorderSide(color: Colors.blueAccent),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),

            const SizedBox(width: 16),
          ],
        ),

        body: BlocBuilder<VoucherBloc, VoucherState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            final voucher = state.voucherModel;

            if (voucher == null) {
              return const Center(child: Text("No voucher available"));
            }

            final finalPrice = state.finalPrice;
            final savings = state.savings;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  _buildHeader(),

                  const SizedBox(height: 20),

                  Text(
                    voucher.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 20),

                  _buildAmountField(context, voucher),

                  const SizedBox(height: 24),

                  const Text(
                    "Payment Method",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),

                  const SizedBox(height: 8),

                  _buildPaymentMethods(context, state, voucher),

                  const SizedBox(height: 24),

                  /// Quantity
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Quantity",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),

                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey.shade300),
                        ),

                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.remove),
                            ),

                            const Text(
                              "1",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.add),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  _buildRedeemSteps(voucher),

                  const SizedBox(height: 28),

                  _buildSummary(finalPrice, savings),

                  const SizedBox(height: 20),

                  _buildPayButton(voucher, finalPrice),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,

        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
        ],
      ),

      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),

        child: Image.network(
          'https://upload.wikimedia.org/wikipedia/commons/thumb/8/81/Zepto_Logo.svg/1280px-Zepto_Logo.svg.png',
          height: 80,
          width: double.infinity,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Widget _buildAmountField(BuildContext context, dynamic voucher) {
    return TextField(
      keyboardType: TextInputType.number,

      onChanged: (val) {
        context.read<VoucherBloc>().add(UpdateAmount(int.tryParse(val) ?? 0));
      },

      decoration: InputDecoration(
        labelText: "Enter Amount (Min: ${voucher.minAmount})",

        filled: true,
        fillColor: Colors.white,

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildPaymentMethods(
    BuildContext context,
    VoucherState state,
    dynamic voucher,
  ) {
    return Row(
      children: voucher.discounts.map<Widget>((d) {
        final isSelected = state.selectedMethod == d.method;

        return Expanded(
          child: Card(
            elevation: 0,
            color: Colors.white,

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),

              side: BorderSide(
                color: isSelected ? Colors.blueAccent : Colors.grey.shade300,
              ),
            ),

            child: RadioListTile<String>(
              value: d.method,
              groupValue: state.selectedMethod,

              activeColor: Colors.blueAccent,

              title: Text(
                "${d.method}  ${d.percent}%",
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),

              onChanged: (val) {
                if (val != null) {
                  context.read<VoucherBloc>().add(ChangePaymentMethod(val));
                }
              },
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildRedeemSteps(dynamic voucher) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        const Text(
          "How to Redeem",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),

        const SizedBox(height: 8),
        ...voucher.redeemSteps.map<Widget>(
          (step) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),

            child: Text(
              "• $step",
              style: TextStyle(color: Colors.grey.shade700),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSummary(double finalPrice, double savings) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(16),
      ),

      child: Column(
        children: [
          Text(
            "Final Price: ₹${finalPrice.toStringAsFixed(0)}",
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 4),

          Text(
            "You Saved ₹${savings.toStringAsFixed(0)}",
            style: const TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPayButton(dynamic voucher, double finalPrice) {
    return SizedBox(
      width: double.infinity,
      height: 52,

      child: ElevatedButton(
        onPressed: voucher.disablePurchase ? null : () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blueAccent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),

          elevation: 4,
        ),

        child: Text(
          "Pay ₹${finalPrice.toStringAsFixed(0)}",

          style: const TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
