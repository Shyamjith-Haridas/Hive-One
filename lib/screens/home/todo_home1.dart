import 'package:flutter/material.dart';

import '../../controller/functions.dart';
import '../../model/todo_model.dart';

class TodoHomee extends StatelessWidget {
  // controller
  final taskNameController = TextEditingController();
  final subTitleController = TextEditingController();

  TodoHomee({super.key});

  @override
  Widget build(BuildContext context) {
    getFunction();
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: ValueListenableBuilder(
            valueListenable: notifierList,
            builder: (BuildContext context, List<TodoModel> todoList,
                Widget? child) {
              return ListView.separated(
                padding: const EdgeInsets.all(10),
                itemCount: todoList.length,
                itemBuilder: (context, index) {
                  final todoData = todoList[index];
                  return SizedBox(
                    child: ListTile(
                      tileColor: Colors.grey.shade300,
                      title: Text(
                        todoData.taskName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        todoData.taskSubTitle,
                        style: const TextStyle(
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.green,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              if (todoData.taskId != null) {
                                deleteFunction(todoData.taskId!);
                              } else {
                                print("unable to delete data");
                              }
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 10);
                },
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text("Add Task"),
        onPressed: () {
          showForm(context);
        },
      ),
    );
  }

  void showForm(BuildContext context) {
    showModalBottomSheet(
      context: context,
      elevation: 5,
      isScrollControlled: true,
      builder: (_) {
        return SizedBox(
          child: Padding(
            padding: EdgeInsets.only(
              top: 15,
              left: 15,
              right: 15,
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextField(
                  controller: taskNameController,
                  decoration: const InputDecoration(
                    hintText: "Add a task",
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: subTitleController,
                  decoration: const InputDecoration(
                    hintText: "Add a sub title",
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton.icon(
                  onPressed: () {
                    addTaskFunction();
                  },
                  icon: const Icon(Icons.add),
                  label: const Text("Add"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void addTaskFunction() async {
    final _task = taskNameController.text;
    final _subTitle = subTitleController.text;

    if (_task.isEmpty || _subTitle.isEmpty) {
      return;
    }

    final taskData = TodoModel(
      taskName: _task,
      taskSubTitle: _subTitle,
    );

    addTask(taskData);

    taskNameController.clear();
    subTitleController.clear();
  }
}
