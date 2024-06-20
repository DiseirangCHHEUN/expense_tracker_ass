import 'package:cloud_firestore/cloud_firestore.dart';

import 'expense.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<Expense>> getExpenses() {
    return _db.collection('expenses').snapshots().map((snapshot) => snapshot
        .docs
        .map((doc) => Expense.fromMap(doc.data(), doc.id))
        .toList());
  }

  Future<void> addExpense(Expense expense) {
    return _db.collection('expenses').add(expense.toMap());
  }

  Future<void> deleteExpense(String id) {
    return _db.collection('expenses').doc(id).delete();
  }

  Future<void> updateExpense(Expense expense) {
    return _db.collection('expenses').doc(expense.id).update(expense.toMap());
  }
}
