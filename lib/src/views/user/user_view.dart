import 'package:flutter/material.dart';
import 'package:socdrawer/src/controllers/user_controller.dart';
import 'package:socdrawer/src/models/user.dart';
import 'package:socdrawer/src/views/components/socieity_card.dart';
import 'package:socdrawer/src/views/user/login_view.dart';

class UserProfilePage extends StatelessWidget {
  UserProfilePage({super.key});

  final User user = getLoggedInUser()!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // User Card at Top
              Card(
                margin: const EdgeInsets.all(16),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                elevation: 8,
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.person,
                              size: 64, color: Colors.grey),
                          const SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${user.name} ${user.surename}',
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                user.email,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton.icon(
                        onPressed: () {
                          logoutUser();
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            Login.routeName,
                            (Route<dynamic> route) => false,
                          );
                        },
                        icon: const Icon(Icons.logout),
                        label: const Text('Logout'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Committee Societies Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Committee Societies',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 8),
              ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: user.comitteeSocieties.length,
                itemBuilder: (context, index) {
                  final society = user.comitteeSocieties[index];
                  return SocieityCard(society: society);
                },
              ),

              // Memberships Section
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
                child: Text(
                  'Memberships',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: user.societies.length,
                itemBuilder: (context, index) {
                  final society = user.societies[index];
                  return SocieityCard(society: society);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
