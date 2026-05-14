
import 'package:flutter/material.dart';

import 'materias.page.dart';

class MateriasHomePage extends StatelessWidget {
const MateriasHomePage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: const Text('Materias')),
      body: AnimatedSwitcher(duration: const Duration (milliseconds: 300),
      child: MateriasPage()
      ),
      floatingActionButton: FloatingActionButton(onPressed: () async{
      },
      child: const Icon((Icons.add)),),
    
    );
  }
}