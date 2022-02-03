import 'package:flutter/material.dart';
import 'package:todo_app/api/firebase_api.dart';
import 'package:todo_app/main.dart';
import 'package:todo_app/modal/todo.dart';
import 'package:todo_app/provider/todos.dart';
import 'package:todo_app/widget/add_todo_dialog.dart';
import 'package:todo_app/widget/completed_list_widget.dart';
import 'package:todo_app/widget/todo_list_widget.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    final tabs = [
      const TodoListWidget(),
      const CompletedListWidget(),
    ];
    return Scaffold(
      appBar: AppBar(title: const Text(MyApp.title)),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white.withOpacity(0.5),
        selectedItemColor: Colors.white,
        currentIndex: selectedIndex,
        onTap: (index) => setState(() {
          selectedIndex = index;
        }),
        // ignore: prefer_const_literals_to_create_immutables
        items: [
          const BottomNavigationBarItem(
              icon: Icon(Icons.fact_check_outlined), label: "Todos"),
          const BottomNavigationBarItem(
              icon: Icon(Icons.done, size: 28), label: "Completed"),
        ],
      ),
      body: StreamBuilder<List<Todo>>(
        stream: FirebaseApi.readTodos(),
        builder: (context, snapshot) {
          final todos = snapshot.data;
          final provider = Provider.of<TodosProvider>(context);
          provider.setTodos(todos!);
          return tabs[selectedIndex];
        },
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: Colors.black,
        onPressed: () => showDialog(
          context: context,
          builder: (context) => const AddToDoDialogPage(),
          barrierDismissible: false,
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
