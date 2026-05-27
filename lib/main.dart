import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'app/app.widget.dart';
import 'features/auth/providers/auth.provider.dart';
import 'features/academic_programs/providers/academic.program.provider.dart';
import 'features/solicitud/providers/document.provider.dart';
import 'features/student/providers/student.provider.dart';
import 'features/subject/providers/materias.provider.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  // Inicializa firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    MultiProvider(
      providers: [
        // AuthProvider debe ir primero para que el redirect guard lo encuentre
        ChangeNotifierProvider(
          create: (_) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => StudentProvider()..loadStudents(),
        ),
        // 2. Agregas el nuevo provider de materias e inicializas sus datos
        ChangeNotifierProvider(
          create: (_) => SubjectProvider()..loadSubjects(),
        ),
        ChangeNotifierProvider(
          create: (_) => DocumentProvider()..loadDocuments(),
        ),
        ChangeNotifierProvider(create: (_) => AcademicProgramProvider()..loadAcademicPrograms()),
      ],
      child: const AppWidget(),
    ),
  );
}
