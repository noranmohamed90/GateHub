class Fee {
  final String id; 
  final String title;
  final String dueDate;
  final double amount;
  bool isSelected;

  Fee({
    required this.id, 
    required this.title,
    required this.dueDate,
    required this.amount,
    this.isSelected = false,
  });
}