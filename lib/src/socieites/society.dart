/// A class that represents a society model
class Socieity {
  const Socieity(this.id, this.name, this.icon, this.joined, this.committee,
      {this.description = "This society has no description"});

  final int id;
  final String name;
  final String icon;
  final bool joined;
  final String description;
  final Map<String, String> committee;
}
