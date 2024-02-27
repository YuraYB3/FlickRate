import 'package:flickrate/domain/category/icategory.dart';
import 'package:flutter/material.dart';

class Category implements ICategory {
  @override
  final String id;
  @override
  final String title;
  @override
  final Color color;

  const Category(
      {required this.id,
      required this.title,
      this.color = const Color.fromARGB(239, 216, 59, 31)});
}
