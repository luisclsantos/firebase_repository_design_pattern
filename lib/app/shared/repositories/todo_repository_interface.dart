import 'package:firebase_repository_design_pattern/app/shared/models/todo_model.dart';

abstract class ITodoRepository {
  Stream<List<TodoModel>> getTodos();
}
