import '../models/society.dart';

class User {
  final String name;
  final String surename;
  final String email;
  final int year;
  final Socieity society;

  User({
    required this.name,
    required this.surename,
    required this.email,
    required this.year,
    required this.society,
  });

  @override
  String toString() =>
      'Full name: $name $surename\nEmail: $email\nStudent year: $year\nSociety: $society';
}
