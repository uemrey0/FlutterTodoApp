import 'package:flutter/material.dart';

class TodoFormWidget extends StatelessWidget {
  final String title;
  final String description;
  final ValueChanged<String> onTitleChanged;
  final ValueChanged<String> onDescriptionChanged;
  final VoidCallback onSavedTodo;
  const TodoFormWidget(
      {Key? key,
      this.title = "",
      this.description = "",
      required this.onTitleChanged,
      required this.onDescriptionChanged,
      required this.onSavedTodo})
      : super(key: key);

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          buildTitle(),
          const SizedBox(
            height: 8,
          ),
          buildDescription(),
          const SizedBox(
            height: 8,
          ),
          buildButton()
        ],
      ));
  Widget buildTitle() => TextFormField(
        maxLines: 1,
        initialValue: title,
        onChanged: onTitleChanged,
        validator: (title) {
          if (title!.isEmpty) {
            return "The title can not be empty";
          }
          return null;
        },
        decoration: const InputDecoration(
          border: UnderlineInputBorder(),
          labelText: "Title",
        ),
      );
  Widget buildDescription() => TextFormField(
        maxLines: 3,
        initialValue: description,
        onChanged: onDescriptionChanged,
        decoration: const InputDecoration(
          border: UnderlineInputBorder(),
          labelText: "Description",
        ),
      );
  Widget buildButton() => SizedBox(
    width: double.infinity,
    child: ElevatedButton(
      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.black)),
      onPressed: onSavedTodo, 
      child: const Text("Save"), 
      ),
  );
}
