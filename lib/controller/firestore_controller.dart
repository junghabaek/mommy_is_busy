import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:mommy_is_busy/controller/auth_controller.dart';
import 'package:mommy_is_busy/models/calendar_event.dart';
import 'package:timezone/standalone.dart' as tz;

class FirestoreController extends GetxController{
  static FirestoreController controller = Get.find();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  RxList<Event> eventList = <Event>[].obs;
  RxMap<DateTime, List<Event>> eventMap = Map<DateTime, List<Event>>().obs;// 이거 되나?
  RxList<DateTime> keyList = <DateTime>[].obs;


  void storeTasks(Event event) async {
    await firestore.collection('user').doc(AuthController.controller.authentication.currentUser!.uid).collection('task')
        .doc(event.hashCode.toString()).set(
      {
        'id' : event.hashCode,
        'createdAt' : event.createdAt,
        'task_name' : event.eventName,
        'deadline' : event.deadline,
        'isDone' : event.isDone,
      }
    );
  }

  void getEvents(DateTime dateTime) async{

    // DateTime from = (dateTime.add(Duration(hours: 9)));
    // DateTime to = from.add(Duration(days: 1));

    // DateTime from = DateTime(2023,7,25);
    // DateTime to = from.add(Duration(days: 1));


    // DateTime from = DateTime(2023,7,25).add(Duration(hours: 9));
    // DateTime to = from.add(Duration(days: 1));

    DateTime from = dateTime;
    DateTime to = from.add(Duration(days: 1));


    //utc +9 에 맞게끔 변환해줘야함.이게 웃긴게 저장할때는 맘대로 utc타임으로 변환해서 저장하면서 (이것까진 이해됨)
    //조건절로 받아올 때는 utc타임으로 변환안해줘서 내가 변환해서 받아와야함
    // 어쨌건 저장할때는 정확한 시간으로 저장되기때문에, 받아올 때 변환을 해주는게 맞다고 본다.

    print(from);
    print(to);
    print('to');

    // QuerySnapshot query = await firestore.collection('user').doc(AuthController.controller.authentication.currentUser!.uid).collection('task').where('createdAt', isLessThan: dateTime).get();
    // await firestore.collection('user').doc(AuthController.controller.authentication.currentUser!.uid).collection('task').where('createdAt', isLessThan: dateTime).get().
    // then((value) => value.docs.forEach((element) { print(element['task_name']);}));
    
    var convertedCollection = await firestore.collection('user').doc(AuthController.controller.authentication.currentUser!.uid).collection('task')
        .withConverter<Event>(fromFirestore: Event.fromFirestore, toFirestore: (Event event, options) => event.toFirestore());

    // await convertedCollection.where('createdAt', isLessThan: dateTime).get().then((QuerySnapshot querySnapshot){ querySnapshot.docs.forEach((e){
    //   eventList.add(e.data() as Event);
    //   });}); // e.data() 하면 event로 받아와짐

    await convertedCollection.where('deadline',isGreaterThanOrEqualTo: from).where('deadline', isLessThanOrEqualTo: to).get().then((QuerySnapshot querySnapshot){ querySnapshot.docs.forEach((e) {
      Event event = e.data() as Event;
      DateTime deadline = event.deadline;
      print(deadline);
      print('deadline');

      if(eventMap.containsKey(deadline)){
        eventMap[deadline]!.add(event);
      }else{
        eventMap[deadline] = <Event>[];
        eventMap[deadline]!.add(event);
      }
    });
    });

    //중복 제거하기
    eventMap.forEach((key, value) {
      eventMap[key] = eventMap[key]!.toSet().toList();
    });

    eventMap.forEach((key, value) {
      value.forEach((element) {print('$key : ${element.eventName}');});
    });


    var temp = eventMap.keys.toList()..sort();
    keyList = temp.obs;

    print(keyList);




    // print(query);
  }


  void updateTaskDone(int hashcode) async {
    await firestore.collection('user').doc(
        AuthController.controller.authentication.currentUser!.uid).collection(
        'task')
        .doc(hashcode.toString()).update(
        {
          'isDone': true,
        }
    );
  }

  void undoUpdateTaskDone (int hashcode) async {
    await firestore.collection('user').doc(
        AuthController.controller.authentication.currentUser!.uid).collection(
        'task')
        .doc(hashcode.toString()).update(
        {
          'isDone': false,
        }
    );
  }


}