/// A class that represents a society model
class Socieity {
  const Socieity(
      this.id, this.name, this.icon, this.joined, this.committee, this.code,
      {this.description = "This society has no description",
      this.discordCode,
      this.instagramHandle,
      this.website,
      this.mail,
      this.whatsapp});

  final int id;
  final String name;
  final String icon;
  final bool joined;
  final String description;
  final String
      code; // For some reason, the union puts a unique code in the url for each group. You'd think this would be enough to navigate to the group but NOOOO you need both that and the name
  final Map<String, String> committee;
  final String? discordCode;
  final String? instagramHandle;
  final String? website;
  final String? mail;
  final String? whatsapp;
}
