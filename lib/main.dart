import 'package:flutter/material.dart';
import 'app.widget.dart';
import 'package:provider/provider.dart';

import 'features/student/providers/student.provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => StudentProvider()..loadStudents(),
        ),
      ],
      child: const AppWidget(),
    ),
  );
}
