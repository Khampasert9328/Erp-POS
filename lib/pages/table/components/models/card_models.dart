import 'package:flutter/material.dart';

class CardModels {
  final String id;
  final String title;
  final Color color;

  const CardModels({required this.id, required this.title, this.color = Colors.orange});
}