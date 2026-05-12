import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app.widget.dart';
import 'features/student/providers/student.provider.dart';
import 'features/subject/providers/materias.provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => StudentProvider()..loadStudents(),
        ),
        // 2. Agregas el nuevo provider de materias e inicializas sus datos
        ChangeNotifierProvider(
          create: (_) => SubjectProvider()..loadSubjects(),
        ),
      ],
      child: const AppWidget(),
    ),
  );
}