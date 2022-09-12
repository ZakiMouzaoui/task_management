import 'package:get/get.dart';

class TaskService extends GetConnect{
  Future<List<dynamic>> getTasks()async{
    final response = await get(
        "http://127.0.0.1:8000/api/tasks",
    );

    return response.body;
  }
}
