import '../models/society.dart';

class Event {
  final String name;
  final String? description;
  final DateTime dateTime;
  final String location;
  final Socieity society;
  final bool isRepeating;
  final bool needsPayment;

  Event({
    required this.name,
    this.description,
    required this.dateTime,
    required this.location,
    required this.society,
    required this.isRepeating,
    required this.needsPayment,
  }) {
    if (dateTime.isBefore(DateTime.now())) {
      throw ArgumentError('Date cannot be in the past');
    }
    if (dateTime.month > 12) {
      throw ArgumentError('Month cannot be greater than 12');
    }
    if (dateTime.day > 31) {
      throw ArgumentError('Day cannot be greater than 31');
    }
    if (dateTime.month < 1) {
      throw ArgumentError('Month cannot be less than 1');
    }
    if (dateTime.day < 1) {
      throw ArgumentError('Day cannot less than 1');
    }
    if (dateTime.hour > 23) {
      throw ArgumentError('Hour cannot be greater than 23');
    }
    if (dateTime.minute > 59) {
      throw ArgumentError('Minutes cannot be greater than 59');
    }
    if (dateTime.hour < 0) {
      throw ArgumentError('Hour cannot be negative');
    }
    if (dateTime.minute < 0) {
      throw ArgumentError('Minutes cannot be negative');
    }
    if (name.length > 50) {
      throw ArgumentError('Event name must be 50 characters or fewer');
    }
    if (description != null && description!.length > 200) {
      throw ArgumentError('Description must be 200 characters or fewer');
    }
  }

  @override
  String toString() =>
      'Society: ${society.name} Name: $name on ${dateTime.toLocal()} at $location';
}
