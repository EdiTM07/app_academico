
import 'package:flutter/material.dart';

import 'students.page.dart';

class StudentsHomePage extends StatelessWidget {
const StudentsHomePage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: const Text('Estudiantes')),
      body: AnimatedSwitcher(duration: const Duration (milliseconds: 300),
      child: StudentsPage()
      ),
      floatingActionButton: FloatingActionButton(onPressed: () async{
      },
      child: const Icon((Icons.add)),),
    
    );
  }
  }
