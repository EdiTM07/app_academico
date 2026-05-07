import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          const CircleAvatar(radius: 50, child: Icon(Icons.person, size: 50)),

          const SizedBox(height: 20),

          const Text(
            'José Rodríguez',
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
