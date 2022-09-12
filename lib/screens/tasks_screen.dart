import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management/controllers/task_controller.dart';
import 'package:task_management/screens/home_screen.dart';
import 'package:task_management/screens/task_screen.dart';
import 'package:task_management/widgets/button_widget.dart';

import '../models/task.dart';
import '../utils/constants.dart';
import 'add_task_screen.dart';

class TasksScreen extends StatelessWidget {
  TasksScreen({Key? key}) : super(key: key);
  final TaskController taskController = Get.put(TaskController(),permanent: true);

  Widget editTaskWidget(Task task, String id){
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20),
      decoration: BoxDecoration(
        color: AppColors.mainColor.withOpacity(0.5),
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20)
        )
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
              child: const ButtonWidget(buttonText: "View", backgroundColor: AppColors.mainColor, textColor: Colors.white),
              onTap: (){
                Get.to(TaskScreen(readOnly: true, task: task, id: id,));
              },
          ),
          GestureDetector(
              child: const ButtonWidget(buttonText: "Edit", backgroundColor: Colors.white, textColor: AppColors.secondaryColor),
              onTap: (){
                Get.to(TaskScreen(readOnly: false, task: task, id: id));
              },
          ),
        ],
      ),
    );
  }

  Widget endToStart(){
    return Container(
      decoration: BoxDecoration(
        color: AppColors.mainColor.withOpacity(0.4),
      ),
      child: const Icon(
        Icons.edit,
        color: Colors.white,
      ),
      alignment: Alignment.centerLeft,
    );
  }

  Widget startToEnd(){
    return Container(
      decoration: BoxDecoration(
        color: Colors.redAccent.withOpacity(0.4),
      ),
      child: const Icon(
        Icons.delete,
        color: Colors.white,
      ),
      alignment: Alignment.centerRight,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: NetworkImage("https://i.pinimg.com/originals/69/ae/b9/69aeb9250da0d7c396814838662a944b.jpg"),
              fit: BoxFit.fill

            )
          ),
        ),
          Positioned(
            child: GestureDetector(
              onTap: (){
                Get.offAll(()=>HomeScreen(), transition: Transition.fade, duration: const Duration(milliseconds: 700));
              },
                child: const Icon(Icons.arrow_back, color: AppColors.secondaryColor,)
            ), top: 60, left: 20,
          ),
          Positioned(
            bottom: 0,
            child: Container(
              height: MediaQuery.of(context).size.height/1.8,
              width:MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20)
                )
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      GestureDetector(
                          child: const Icon(Icons.home, color: AppColors.secondaryColor),
                        onTap: (){
                            Get.offAll(()=>HomeScreen(), transition: Transition.fade, duration: const Duration(milliseconds: 700));
                        },
                      ),
                      const SizedBox(width: 10,),
                      Container(
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(50)
                        ),
                        child: GestureDetector(
                          onTap: (){
                            Get.to(()=>AddTaskScreen(), transition: Transition.fade, duration: const Duration(milliseconds: 700));
                          },
                          child: const Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                      Expanded(child: Container()),
                      const Icon(Icons.event_note_outlined, color: AppColors.secondaryColor,),
                      const SizedBox(width: 10,),

                      GetBuilder<TaskController>(
                        builder: (controller)=> Text(
                          taskController.tasks.length.toString(),
                          style: const TextStyle(
                            fontSize: 22
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height:20),
                  Expanded(
                    child: GetBuilder<TaskController>(
                      builder: (context)=>ListView.builder(
                        itemCount: taskController.tasks.length,
                          itemBuilder: (context,index) =>
                              Dismissible(
                                background: endToStart(),
                                secondaryBackground: startToEnd(),
                                key: UniqueKey(),
                                onDismissed: (DismissDirection direction){
                                  taskController.deleteTask(taskController.tasks[index].id);
                                },
                                confirmDismiss: (DismissDirection direction) async{
                                  if(direction == DismissDirection.startToEnd){
                                    showModalBottomSheet(
                                        context: context,
                                        builder: (_) => editTaskWidget(taskController.tasks[index], taskController.tasks[index].id),
                                        backgroundColor: Colors.transparent,
                                        barrierColor: Colors.transparent
                                    );
                                    return false;
                                  }
                                  return true;
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(bottom: 10),
                                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                                  decoration: const BoxDecoration(
                                    color: AppColors.textHolder
                                  ),
                                  child: Center(
                                    child: Text(
                                        taskController.tasks[index].name,
                                      style: const TextStyle(
                                        fontSize: 20,
                                        color:AppColors.textGrey
                                      ),
                                    ),
                                  ),
                                ),
                              )
                      ),
                    ),
                  )
                ],
              )
            ),
          )
      ]
      ),
    );
  }
}
