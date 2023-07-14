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

  void initiateFridge() async{
    await firestore.collection('user').doc(AuthController.controller.authentication.currentUser!.uid).collection('fridge').doc('');
  }

  Future<void> getEvents(DateTime dateTime) async{

    // DateTime from = (dateTime.add(Duration(hours: 9)));
    // DateTime to = from.add(Duration(days: 1));

    // DateTime from = DateTime(2023,7,25);
    // DateTime to = from.add(Duration(days: 1));


    // DateTime from = DateTime(2023,7,25).add(Duration(hours: 9));
    // DateTime to = from.add(Duration(days: 1));

    DateTime from = dateTime;
    DateTime to = from.add(Duration(days: 1));

    // UTC 표현법때문에 고생했다.
    // 2023-07-25 08:00:00.000 이런식으로 마지막에 Z가 없으면 로컬타임이고
    // 2023-07-25 08:00:00.000Z 이런식으로 Z가 붙어있으면 UTC이다,
    // 즉 위 두개의 시간은 서로 다른 시간이다.
    // 로컬 타임을 UTC로 변환하려면 시차를 더하거나 빼준다음에 Z를 붙인다.
    // 애초에 문제가 생겼던 이유는 DatePicker는 UTC를 반환하고
    // DateTime.now() 는 로컬타임을 반환한다.
    // firebase에는 로컬타임으로 변환되어서 올라간다. 로컬타임을 업데이트 하면 그대로 올라가고, utc를 올리면 로컬로 변환된 시간이 올라간다.
    // 결론은 어떤 값을 시스템에서 받아오거나 어떤 프로그램을 통해 받아온다면 그 값이 utc인지 로컬타임인지 확인하는게 꼭 중요하다.


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
      value.forEach((element) {print('============$key : ${element.eventName}');});
    });


    var temp = eventMap.keys.toList()..sort();
    keyList = temp.obs;

    print('123123123123123');
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