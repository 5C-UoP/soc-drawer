import 'package:flutter/material.dart';
import 'package:socdrawer/src/models/society.dart';
import 'package:socdrawer/src/views/socieites/socieities_details_view.dart';

class SocieityCard extends StatelessWidget {
  const SocieityCard({
    super.key,
    required this.society,
  });

  final Socieity society;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          SocietyItemDetailsView.routeName,
          arguments: {'society': society},
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 4,
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: ListTile(
          leading: CircleAvatar(
            foregroundImage: AssetImage(society.icon),
          ),
          title: Text(society.name),
          trailing: society.joined
              ? const Icon(Icons.arrow_forward_ios, size: 16)
              : const Text("Join"),
        ),
      ),
    );
  }
}
