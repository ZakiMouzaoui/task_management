import 'dart:convert';

import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:task_management/services/task_service.dart';

import '../models/task.dart';
import  'package:http/http.dart' as http;

class TaskController extends GetxController{
  var tasks = <Task>[].obs;
  final TaskService service = TaskService();
  Box<Task> box = Hive.box("task_box");

  @override
  void onInit() {
    getTasks();
    super.onInit();
  }

  void getTasks() async{
    tasks = <Task>[].obs;
    for (var task in box.values) {
      tasks.add(task);
    }

    final response = await http.get(Uri.parse("http://192.168.1.103:8000/api/tasks"));
    final jsonData = jsonDecode(response.body)["tasks"];

    for (int i=0; i<jsonData.length; i++){
      tasks.add(Task(id: jsonData[i]["id"].toString(), name: jsonData[i]["title"], detail: jsonData[i]["detail"]));
    }
    update();
  }

  void addTask(String title, String detail) async{
    //box.add(task);
    //tasks.add(task);

    await http.post(
        Uri.parse("http://192.168.1.103:8000/api/tasks"),
        body: {
          "title": title,
          "detail": detail
        }
    );
    getTasks();
  }

  void editTask(Task task, String id) async{
    //tasks[index] = task;
    //box.putAt(index, task);

    await http.put(
        Uri.parse("http://192.168.1.103:8000/api/tasks/$id"),
        body: {
          "title": task.name,
          "detail": task.detail
        }
    );

    getTasks();
  }

  void deleteTask(String id) async{
    //tasks.removeAt(index);
    //box.deleteAt(index);
    await http.delete(
        Uri.parse("http://192.168.1.103:8000/api/tasks/$id"),
    );
    getTasks();
  }
}
