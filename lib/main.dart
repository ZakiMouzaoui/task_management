import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:task_management/models/task.dart';
import 'package:task_management/screens/home_screen.dart';

void main() async{
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());
  await Hive.openBox<Task>("task_box");

  runApp(const TaskManagementApp());
}

class TaskManagementApp extends StatelessWidget {
  const TaskManagementApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: "/",
      debugShowCheckedModeBanner: false,
      title: 'Flutter Task Manager',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
        home: AnimatedSplashScreen(
          splash: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("todo_logo.jpg"),
              )
            ),
          ),
          splashIconSize: 120,
          splashTransition: SplashTransition.fadeTransition,
          nextScreen: HomeScreen(),
        ),
    );
  }
}
