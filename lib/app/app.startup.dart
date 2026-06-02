import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../features/auth/providers/auth.provider.dart';

class AppStartup extends StatefulWidget {
  final Widget child;

  const AppStartup({
    super.key,
    required this.child,
  });

  @override
  State<AppStartup> createState() => _AppStartupState();
}

class _AppStartupState extends State<AppStartup> {

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AuthProvider>().initAuth();
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
