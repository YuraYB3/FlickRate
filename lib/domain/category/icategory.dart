import 'package:flutter/material.dart';

abstract interface class ICategory {
  final String id;
  final String title;
  final Color color;

  ICategory({required this.id, required this.title, required this.color});
}
