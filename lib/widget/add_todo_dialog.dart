import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/modal/todo.dart';
import 'package:todo_app/provider/todos.dart';
import 'todo_form_widget.dart';

class AddToDoDialogPage extends StatefulWidget {
  const AddToDoDialogPage({Key? key}) : super(key: key);

  @override
  State<AddToDoDialogPage> createState() => _AddToDoDialogPageState();
}

class _AddToDoDialogPageState extends State<AddToDoDialogPage> {
  final _formKey = GlobalKey<FormState>();
  String title = "";
  String description = "";

  @override
  Widget build(BuildContext context) => AlertDialog(
        content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              const Text("Add Todo",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
              const SizedBox(
                height: 8,
              ),
              TodoFormWidget(
                onTitleChanged: (title) => setState(() => this.title = title),
                onDescriptionChanged: (description) =>
                    setState(() => this.description = description),
                onSavedTodo: addTodo,
              ),
            ],
          ),
        ),
      );

  void addTodo() {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    } else {
      final todo = Todo(
          createdTime: DateTime.now(),
          title: title,
          description: description,
          id: DateTime.now().toString());
      final provider = Provider.of<TodosProvider>(context, listen: false);
      provider.addTodo(todo);
      Navigator.of(context).pop();
    }
  }
}
