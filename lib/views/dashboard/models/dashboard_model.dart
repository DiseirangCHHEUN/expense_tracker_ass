class Expense {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final String category;
  final String type;
  final String? des;

  Expense({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
    required this.type,
    this.des,
  });

  factory Expense.fromMap(Map<String, dynamic> data, String documentId) {
    return Expense(
      id: documentId,
      title: data['title'],
      amount: data['amount'],
      date: DateTime.parse(data['date']),
      category: data['category'] ?? 'Uncategorized',
      type: data['type'] ?? 'expense',
      des: data['des'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'amount': amount,
      'date': date.toIso8601String(),
      'category': category,
      'type': type,
    };
  }
}
