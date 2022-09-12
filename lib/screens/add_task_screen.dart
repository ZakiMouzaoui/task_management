import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management/controllers/task_controller.dart';
import 'package:task_management/screens/tasks_screen.dart';
import 'package:task_management/utils/constants.dart';
import 'package:task_management/widgets/button_widget.dart';
import 'package:task_management/widgets/text_field_widget.dart';


class AddTaskScreen extends StatelessWidget {
  AddTaskScreen({Key? key}) : super(key: key);
  final TaskController taskController = Get.put(TaskController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController detailController = TextEditingController();


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
                      readOnly: false,
                      controller: nameController,
                      hintText: "Task Name",
                      radius: 20
                  ),
                  const SizedBox(height: 20,),
                  TextFieldWidget(
                      readOnly: false,
                      controller: detailController,
                      hintText: "Task Details",
                      maxLines: 3,
                      radius: 20
                  ),
                  const SizedBox(height: 20,),
                  GestureDetector(
                    onTap: (){
                      if(nameController.text.isNotEmpty && detailController.text.isNotEmpty){
                        taskController.addTask(nameController.text, detailController.text);
                        Get.off(()=>TasksScreen(), transition: Transition.fade, duration: const Duration(milliseconds: 700));
                      }
                    },
                    child: const ButtonWidget(
                        buttonText: "Add",
                        backgroundColor: AppColors.mainColor,
                        textColor: Colors.white
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
