import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'app/app.startup.dart';
import 'features/user/providers/user.provider.dart';
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
        // UserProvider debe ir primero porque AuthProvider depende de él
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
        ChangeNotifierProxyProvider<UserProvider, AuthProvider>(
          create: (context) =>
              AuthProvider(userProvider: context.read<UserProvider>()),
          update: (context, userProvider, previous) =>
              previous ?? AuthProvider(userProvider: userProvider),
        ),
        ChangeNotifierProvider(
          create: (_) => StudentProvider()..loadStudents(),
        ),
        ChangeNotifierProvider(
          create: (_) => SubjectProvider()..loadSubjects(),
        ),
        ChangeNotifierProvider(
          create: (_) => DocumentProvider()..loadDocuments(),
        ),
        ChangeNotifierProvider(
          create: (_) => AcademicProgramProvider()..loadAcademicPrograms(),
        ),
      ],
      child: const AppStartup(child: AppWidget()),
    ),
  );
}
