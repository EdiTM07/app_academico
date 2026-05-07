import 'package:flutter/material.dart';

class ChatSignaturePage extends StatelessWidget {
  const ChatSignaturePage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text('Chat de materia'),
      ),

      body: ListView(

        padding: const EdgeInsets.all(16),

        children: [

          Align(
            alignment: Alignment.centerLeft,

            child: Container(

              padding: const EdgeInsets.all(12),

              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(16),
              ),

              child: const Text('Hola 👋'),
            ),
          ),

          const SizedBox(height: 10),

          Align(
            alignment: Alignment.centerRight,

            child: Container(

              padding: const EdgeInsets.all(12),

              decoration: BoxDecoration(
                color: Colors.indigo.shade200,
                borderRadius: BorderRadius.circular(16),
              ),

              child: const Text('Hola profesor'),
            ),
          ),
        ],
      ),
    );
  }
}
