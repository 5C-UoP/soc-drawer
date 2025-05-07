import '../models/society.dart';

class User {
  final String name;
  final String surename;
  final String email;
  final int year;
  final List<Socieity> societies;
  final List<Socieity> comitteeSocieties;
  final String password;

  User(
      {required this.name,
      required this.surename,
      required this.email,
      required this.year,
      required this.societies,
      required this.password,
      required this.comitteeSocieties});

  @override
  String toString() =>
      'Full name: $name $surename\nEmail: $email\nPassword $password\nStudent year: $year\nSociety: $societies\nCommittee: $comitteeSocieties';
}
