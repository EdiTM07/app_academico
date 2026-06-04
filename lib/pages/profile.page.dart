import 'package:app_academico/features/user/providers/user.provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().currentUser;
    if (user == null) {
      return const Center(child: CircularProgressIndicator());
    }
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(user.photoUrl),
            backgroundColor: Colors.transparent,
            child: user.photoUrl.isEmpty
                ? Icon(Icons.person, color: Colors.indigo)
                : null,
          ),

          const SizedBox(height: 20),

          Text(
            user.firstName,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),

          Text(
            'Perfil de usuario',
            style: TextStyle(color: Colors.grey.shade700),
          ),
        ],
      ),
    );
  }
}
