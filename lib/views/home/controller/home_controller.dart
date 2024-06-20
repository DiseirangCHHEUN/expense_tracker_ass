import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/views/expense/expense.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var textController = TextEditingController();
  List pageItem = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];

  int currentIndex = 0;

  void goPreviouse() {
    currentIndex == 0 ? currentIndex = 0 : currentIndex--;
    update();
  }

  void goNext() {
    int limitNum = pageItem.length - 1;
    currentIndex == limitNum ? currentIndex = limitNum : currentIndex++;
    update();
  }

  addNewItemToList({required String newItem}) {
    pageItem.add(newItem);
    update();
  }
}

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
