import 'package:flutter/material.dart';

class InfoTitle extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const InfoTitle({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).colorScheme.secondary),
      title: Text(
        label,
        style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
      ),
      subtitle: Text(
        value,
        style: const TextStyle(fontSize: 15, color: Colors.black87),
      ),
      dense: true,
    );
  }
}
