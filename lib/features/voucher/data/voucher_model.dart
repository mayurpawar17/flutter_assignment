class VoucherModel {
  final String id, title;
  final int minAmount, maxAmount;
  final bool disablePurchase;
  final List<Map<String, dynamic>> discounts;
  final List<String> redeemSteps;

  VoucherModel({
    required this.id,
    required this.title,
    required this.minAmount,
    required this.maxAmount,
    required this.disablePurchase,
    required this.discounts,
    required this.redeemSteps,
  });

  factory VoucherModel.fromJson(Map<String, dynamic> json) {
    return VoucherModel(
      id: json['id'],
      title: json['title'],
      minAmount: json['minAmount'],
      maxAmount: json['maxAmount'],
      disablePurchase: json['disablePurchase'],
      discounts: List<Map<String, dynamic>>.from(json['discounts']),
      redeemSteps: List<String>.from(json['redeemSteps']),
    );
  }
}
