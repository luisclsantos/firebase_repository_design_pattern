import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_repository_design_pattern/app/shared/models/todo_model.dart';
import 'todo_repository_interface.dart';

class TodoRepository implements ITodoRepository {
  FirebaseFirestore firestore;

  TodoRepository({required this.firestore});

  @override
  Stream<List<TodoModel>> getTodos() {
    return firestore
        .collection('todos')
        .orderBy('position')
        .snapshots()
        .map((query) {
      return query.docs.map((doc) {
        return TodoModel.fromDocument(doc);
      }).toList();
    });
  }
}
