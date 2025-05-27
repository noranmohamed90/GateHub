class PaymentHistory {
  final DateTime paymentDate;
  final double amount;
  final List<int> paidFinesIds;

  PaymentHistory({
    required this.paymentDate,
    required this.amount,
    required this.paidFinesIds,
  });
}