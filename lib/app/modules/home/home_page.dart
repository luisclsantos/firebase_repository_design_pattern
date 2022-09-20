import 'package:firebase_repository_design_pattern/app/shared/models/todo_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'home_controller.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key? key, this.title = "Home Page"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Observer(
        builder: (_) {
          if (controller.todoList!.hasError) {
            return Center(
              child: ElevatedButton(
                onPressed: controller.getList(),
                child: Text('Error'),
              ),
            );
          }

          if (controller.todoList!.data == null) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          List<TodoModel> list = controller.todoList!.data;

          return ListView.builder(
            itemCount: list.length,
            itemBuilder: (_, index) {
              TodoModel model = list[index];
              return ListTile(
                title: Text(model.title),
                onLongPress: () {
                  _showDialog(model);
                },
                trailing: Checkbox(
                  value: model.check,
                  onChanged: (check) {
                    model.check = check!;
                    model.save();
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.red,
        icon: Icon(
          FeatherIcons.plus,
          color: Colors.white,
          size: 20,
        ),
        elevation: 10,
        onPressed: _showDialog,
        label: Text('Adicionar'),
      ),
    );
  }

  _showDialog([TodoModel? model]) {
    model ??= TodoModel();
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text('Adicionar Novo Todo'),
          content: TextFormField(
            initialValue: model!.title,
            onChanged: (value) => model!.title = value,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              labelText: "Escreva...",
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Modular.to.pop();
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () async {
                await model!.save();
                Modular.to.pop();
              },
              child: Text('Adicionar'),
            ),
          ],
        );
      },
    );
  }
}
