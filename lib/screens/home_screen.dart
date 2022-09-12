import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management/controllers/task_controller.dart';
import 'package:task_management/screens/add_task_screen.dart';
import 'package:task_management/screens/tasks_screen.dart';
import 'package:task_management/utils/constants.dart';
import 'package:task_management/widgets/button_widget.dart';


class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final taskController = Get.put(TaskController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(left: 20, right: 20),
        height: double.maxFinite,
        width: double.maxFinite,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/welcome.jpg"),
            fit: BoxFit.cover
          )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Hello",
              style: TextStyle(
                color: AppColors.mainColor,
                fontSize: 60,
                fontWeight: FontWeight.bold
              ),
            ),
            const Text(
              "start your beautiful day",
              style: TextStyle(
                color: AppColors.mainColor,
                fontSize: 15
              ),
            ),
            const SizedBox(height: 350,),
            GestureDetector(
              onTap: (){
                Get.to(()=>AddTaskScreen(), transition: Transition.fadeIn, duration: const Duration(milliseconds: 700));
              },
              child: const ButtonWidget(
                  buttonText: "Add Task",
                  backgroundColor: AppColors.mainColor,
                  textColor: Colors.white
              ),
            ),
            GestureDetector(
              onTap: (){
                Get.to(()=>TasksScreen(), transition: Transition.fadeIn, duration: const Duration(milliseconds: 700));
                taskController.getTasks();
              },
              child: const ButtonWidget(
                  buttonText: "View All",
                  backgroundColor: Colors.white,
                  textColor: AppColors.mainColor
              ),
            )
          ],
        ),
      ),
    );
  }
}
