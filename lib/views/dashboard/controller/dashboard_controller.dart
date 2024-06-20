import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/views/dashboard/models/dashboard_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../home/home_view.dart';
import '../../report/report_view.dart';
import '../../setting/setting_view.dart';
import '../data/dropdown_item.dart';

class DashboardController extends GetxController {
  int bottomNavIndex = 0;

  final page = [
    const HomeView(),
    const ReportView(),
    SettingView(),
  ];

  changeIndex(int index) {
    bottomNavIndex = index;
    update();
  }

  final TextEditingController colorController = TextEditingController();
  ExpensionType? selectedColor;
  onSelectColor(ExpensionType? color) {
    selectedColor = color;
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
