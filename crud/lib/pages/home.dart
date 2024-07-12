import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud/models/todo.dart';
import 'package:crud/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final DatabaseService _databaseService = DatabaseService();
  final TextEditingController todoController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: _appBar(),
      body: _buildUI(),
      floatingActionButton: FloatingActionButton(
        onPressed: _displayTextInputDialog,
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  PreferredSizeWidget _appBar() {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.primary,
      title: const Text(
        "Todo",
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Widget _buildUI() {
    return SafeArea(
        child: Column(
      children: [
        _messagesListView(),
      ],
    ));
  }

  Widget _messagesListView() {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.80,
      width: MediaQuery.sizeOf(context).width,
      child: StreamBuilder(
        stream: _databaseService.getTodos(),
        builder: (context, snapshot) {
          List todos = snapshot.data?.docs ?? [];
          if (todos.isEmpty) {
            return const Center(
              child: Text("Add a todo!"),
            );
          }
          return ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) {
                Todo todo = todos[index].data();
                String todoId = todos[index].id;
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 10,
                  ),
                  child: ListTile(
                    tileColor: Theme.of(context).colorScheme.primaryContainer,
                    title: Text(todo.task),
                    subtitle: Text(DateFormat("dd-MM-yyyy h:mm a")
                        .format(todo.updatedOn.toDate())),
                    trailing: Checkbox(
                      value: todo.isDone,
                      onChanged: (value) {
                        Todo updatedTodo = todo.copyWith(
                            isDone: !todo.isDone, updatedOn: Timestamp.now());
                        _databaseService.updateTodo(todoId, updatedTodo);
                      },
                    ),
                    onLongPress: () {
                      _databaseService.deleteTodo(todoId);
                    },
                  ),
                );
              });
        },
      ),
    );
  }

  Future _displayTextInputDialog() {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Add a todo"),
            content: TextField(
              controller: todoController,
              decoration: const InputDecoration(hintText: "Todo..."),
            ),
            actions: <Widget>[
              MaterialButton(
                color: Theme.of(context).colorScheme.primary,
                onPressed: () {
                  Todo todo = Todo(
                      task: todoController.text,
                      isDone: false,
                      createdOn: Timestamp.now(),
                      updatedOn: Timestamp.now());
                  _databaseService.addTodo(todo);
                  Navigator.pop(context);
                  todoController.clear();
                },
                textColor: Colors.white,
                child: Text("Ok"),
              )
            ],
          );
        });
  }
}
