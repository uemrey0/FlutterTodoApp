import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/modal/todo.dart';
import 'package:todo_app/pages/edit_todo_page.dart';
import 'package:todo_app/provider/todos.dart';

import '../utils.dart';

class TodoWidget extends StatelessWidget {
  final Todo todo;
  const TodoWidget({Key? key, required this.todo}) : super(key: key);

  deleteTodo(BuildContext context) {
    final provider = Provider.of<TodosProvider>(context, listen: false);
    provider.removeTodo(todo);
    Utils.showSnackBar(context, "Deleted the task");
  }

  editTodo(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => EditTodoPage(todo: todo),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Slidable(
              key: Key(todo.id),
              startActionPane: ActionPane(
                motion: const ScrollMotion(),
                //BUG: Error for a second that: a dismissed slidable widget is still part of the tree.
                // dismissible: DismissiblePane(
                //   key: Key(todo.id),
                //   onDismissed: () {
                //     deleteTodo(context);
                //   },
                // ),
                children: [
                  SlidableAction(
                    onPressed: deleteTodo,
                    backgroundColor: const Color(0xFFFE4A49),
                    foregroundColor: Colors.white,
                    icon: Icons.delete,
                    label: 'Delete',
                  ),
                ],
              ),
              endActionPane: ActionPane(
                motion: const ScrollMotion(),
                children: [
                  SlidableAction(
                    onPressed: editTodo,
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    icon: Icons.edit,
                    label: 'Edit',
                  ),
                ],
              ),
              child: buildTodo(context)),
        ),
      );
  Container buildTodo(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Checkbox(
            value: todo.isDone,
            onChanged: (_) {
              final provider =
                  Provider.of<TodosProvider>(context, listen: false);
              final isDone = provider.toggleTodoStatus(todo);
              Utils.showSnackBar(context,
                  isDone ? "Task completed" : "Task marked as incompleted");
            },
            checkColor: Colors.white,
            activeColor: Theme.of(context).primaryColor,
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(todo.title,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: Theme.of(context).primaryColor)),
              if (todo.description.isNotEmpty)
                Container(
                  margin: const EdgeInsets.all(4),
                  child: Text(
                    todo.description,
                    style: const TextStyle(
                      fontSize: 20,
                      height: 1.5,
                    ),
                  ),
                ),
            ],
          )),
        ],
      ),
    );
  }
}
