import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:mommy_is_busy/controller/auth_controller.dart';
import 'package:mommy_is_busy/models/calendar_event.dart';

class FirestoreController extends GetxController{
  static FirestoreController controller = Get.find();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  
  void storeTasks(Event event, DateTime dateTime) async {
    await firestore.collection('user').doc(AuthController.controller.authentication.currentUser!.uid).collection('task')
        .doc(event.createdAt.toString()).set(
      {
        'createdAt' : event.createdAt,
        'task_name' : event.eventName,
        'deadline' : dateTime,
        'isDone' : event.isDone,
      }
    );
  }
}