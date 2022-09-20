import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_repository_design_pattern/app/shared/repositories/todo_repository.dart';
import 'package:firebase_repository_design_pattern/app/shared/repositories/todo_repository_interface.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'home_controller.dart';

import 'home_page.dart';

class HomeModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => HomeController(i.get())),
    Bind<ITodoRepository>(
        (i) => TodoRepository(firestore: FirebaseFirestore.instance)),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, __) => HomePage()),
  ];
}
