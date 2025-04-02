
abstract class BalanceState {}

class UpdateBalanceState extends BalanceState{
      final double balance;
      final double pendingFees;
      final String lastPaymentDate;
      final List<Map<String, String>> transactions;

  UpdateBalanceState(  {
   required this.balance,
   required this.pendingFees,
   required this.lastPaymentDate,
   required this.transactions,
   });

   UpdateBalanceState copyWith({
         double? balance,
         double ?pendingFees,
         String ?lastPaymentDate,
         List<Map<String, String>>? transactions,

   })
   {
    return UpdateBalanceState(
      balance: balance??this.balance, 
      pendingFees: pendingFees??this.pendingFees,
       lastPaymentDate: lastPaymentDate??this.lastPaymentDate, 
       transactions: transactions ?? this.transactions);

   }
}