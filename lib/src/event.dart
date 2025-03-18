class Event {
  final String name;
  final String? description;
  final DateTime dateTime;
  final String location;
  final String society;

  Event({
    required this.name,
    this.description,
    required this.dateTime,
    required this.location,
    required this.society,
  });

  @override
  String toString() => '$society event: $name on ${dateTime.toLocal()} at $location';
}