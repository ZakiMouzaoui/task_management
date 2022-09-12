import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management/controllers/task_controller.dart';
import 'package:task_management/screens/tasks_screen.dart';

import '../models/task.dart';
import '../utils/constants.dart';
import '../widgets/button_widget.dart';
import '../widgets/text_field_widget.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({Key? key, required this.task, this.readOnly=false, required this.id}) : super(key: key);
  final Task task;
  final bool readOnly;
  final String id;

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController(text: task.name);
    final TextEditingController detailController = TextEditingController(text: task.detail);
    final TaskController taskController = Get.put(TaskController());

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(left: 20, right: 20),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: NetworkImage("https://media.istockphoto.com/photos/to-do-list-text-on-notepad-picture-id1285308242?b=1&k=20&m=1285308242&s=170667a&w=0&h=K-UO77yYEQAKjRNLhgXADlyRIqrPkB8sC-4mKcyMgC4="),
                fit: BoxFit.cover
            )
        ),

        child: SingleChildScrollView(
          //physics: NeverScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  const SizedBox(height: 30,),
                  GestureDetector(
                    child: const Icon(Icons.arrow_back,color: AppColors.secondaryColor,),
                    onTap: (){
                      Get.back();
                    },
                  ),
                ],
              ),
              const SizedBox(height: 300,),
              Column(
                children: [
                  TextFieldWidget(
                      readOnly: readOnly,
                      controller: nameController,
                      hintText: "Task Name",
                      radius: 20
                  ),
                  const SizedBox(height: 20,),
                  TextFieldWidget(
                      readOnly: readOnly,
                      controller: detailController,
                      hintText: "Task Details",
                      maxLines: 3,
                      radius: 20
                  ),
                  const SizedBox(height: 20,),
                  !readOnly ? GestureDetector(
                    onTap: (){
                      if(nameController.text.isNotEmpty && detailController.text.isNotEmpty){
                        taskController.editTask(Task(
                            id: id,
                            name: nameController.text,
                            detail: detailController.text
                        ), id);
                        Get.off(()=>TasksScreen(), transition: Transition.fade, duration: const Duration(milliseconds: 700));
                      }
                    },
                    child: const ButtonWidget(
                        buttonText: "Edit",
                        backgroundColor: AppColors.mainColor,
                        textColor: Colors.white
                    ),
                  ) : Container()
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
