import 'package:firebase_repository_design_pattern/app/shared/models/todo_model.dart';
import 'package:firebase_repository_design_pattern/app/shared/repositories/todo_repository_interface.dart';
import 'package:mobx/mobx.dart';

part 'home_controller.g.dart';

class HomeController = HomeControllerBase with _$HomeController;

abstract class HomeControllerBase with Store {
  final ITodoRepository repository;

  @observable
  ObservableStream<List<TodoModel>?>? todoList;

  // ignore: type_init_formals
  HomeControllerBase(ITodoRepository this.repository) {
    getList();
  }

  @action
  getList() {
    todoList = repository.getTodos().asObservable();
  }
}
