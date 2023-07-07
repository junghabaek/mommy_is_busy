import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:mommy_is_busy/controller/auth_controller.dart';
import 'package:mommy_is_busy/models/calendar_event.dart';

class FirestoreController extends GetxController{
  static FirestoreController controller = Get.find();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  RxList<Event> eventList = <Event>[].obs;

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

  void getEvents(DateTime dateTime) async{
    // QuerySnapshot query = await firestore.collection('user').doc(AuthController.controller.authentication.currentUser!.uid).collection('task').where('createdAt', isLessThan: dateTime).get();
    // await firestore.collection('user').doc(AuthController.controller.authentication.currentUser!.uid).collection('task').where('createdAt', isLessThan: dateTime).get().
    // then((value) => value.docs.forEach((element) { print(element['task_name']);}));
    
    var convertedCollection = await firestore.collection('user').doc(AuthController.controller.authentication.currentUser!.uid).collection('task')
        .withConverter<Event>(fromFirestore: Event.fromFirestore, toFirestore: (Event event, options) => event.toFirestore());

    await convertedCollection.where('createdAt', isLessThan: dateTime).get().then((QuerySnapshot querySnapshot){ querySnapshot.docs.forEach((e){
      eventList.add(e.data() as Event);
      });}); // e.data() 하면 event로 받아와짐





    // print(query);
  }
}