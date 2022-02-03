import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/provider/todos.dart';
import 'package:todo_app/widget/todo_widget.dart';

class CompletedListWidget extends StatelessWidget {
  const CompletedListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TodosProvider>(context);
    final todos = provider.todosCompleted;
    if (todos.isEmpty) {
      return const Center(
        child: Text(
          "No completed task data...",
          style: TextStyle(fontSize: 20),
        ),
      );
    }
    return ListView.separated(
      itemBuilder: (context, index) {
        final todo = todos[index];
        return TodoWidget(todo: todo);
      },
      itemCount: todos.length,
      separatorBuilder: (context, index) => Container(
        height: 8,
      ),
    );
  }
}