import 'package:flutter/material.dart';
import 'package:mommy_is_busy/controller/firestore_controller.dart';
import 'package:mommy_is_busy/screens/bottom_button_icons.dart';
import 'package:mommy_is_busy/screens/home.dart';
import 'package:get/get.dart';
import 'package:mommy_is_busy/models/calendar_event.dart';

class TaskListScreen extends StatelessWidget {
  TaskListScreen({super.key, required this.mapKey});

  DateTime mapKey;



  @override
  Widget build(BuildContext context) {

    bool isEveryTaskDone(List<Event> eventList){

      bool result = true;

      eventList.forEach((element) {
        if (element.isDone==false){
          result = false;
        }
      });

      return result;
    }



    // if(isEveryTaskDone(FirestoreController.controller.eventMap[mapKey]!)){
    //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Every task is done for this time.')));
    // }

    return Scaffold(
      backgroundColor: Colors.orange,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
            Expanded(
              child:
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 60, 12, 0),
                  child: Container(
                    color: Colors.blue,
                    child: Column(
                      children: [
                        SizedBox(height: 20,),
                        Text('끝난 일은 옆으로 밀어주세요.'),
                        Expanded(
                          child: ListView.builder(itemCount: FirestoreController.controller.eventMap[mapKey]!.length
                            , itemBuilder: (context, idx){
                            final eachTask = FirestoreController.controller.eventMap[mapKey]![idx];

                            // print(eachTask.eventName);
                            // FirestoreController.controller.eventMap[mapKey]!.forEach((element) {print(element.eventName);});
                              { // 끝마치치 않은 task들만 보여주기 -- return null 하면 안되서 SizedBox()를 대신 리턴함

                                if(eachTask.isDone==false) {
                                  return Dismissible(
                                      key: UniqueKey(),
                                      onDismissed: (direction) {
                                        FirestoreController.controller.updateTaskDone(
                                            eachTask.id);
                                        FirestoreController.controller.eventMap[mapKey]![idx].isDone=true;
                                        print(eachTask.hashCode);
                                        // 모든 태스크를 완료했다면
                                        if(isEveryTaskDone(FirestoreController.controller.eventMap[mapKey]!)){
                                          ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(
                                                  content: Text('Every task is done for this deadline.'),
                                              action: SnackBarAction(
                                                label: 'Undo',
                                                  onPressed: (){
                                                  FirestoreController.controller.undoUpdateTaskDone(eachTask.id);
                                                  FirestoreController.controller.eventMap[mapKey]![idx].isDone=false;
                                                  Get.offAll(()=>TaskListScreen(mapKey: mapKey));
                                                  },
                                              )
                                              ,));
                                          Get.offAll(()=>Home());
                                        }else {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(
                                                  content: Text('Task Done'),
                                              action: SnackBarAction(
                                                label: 'Undo',
                                                onPressed: (){
                                                  FirestoreController.controller.undoUpdateTaskDone(eachTask.id);
                                                  FirestoreController.controller.eventMap[mapKey]![idx].isDone=false;
                                                  Get.offAll(()=>TaskListScreen(mapKey: mapKey));
                                                },
                                              ),)
                                          );
                                        }
                                      },
                                      background: Container(color: Colors.deepOrange,),
                                      child: Column(
                                        children: [
                                          Container(
                                            color: Colors.yellow,
                                            child: ListTile(
                                              title: Text(FirestoreController.controller
                                                  .eventMap[mapKey]![idx].eventName),
                                            ),
                                          ),
                                          SizedBox(height: 3,)
                                        ],
                                      ));
                                } else{
                                  return SizedBox();
                                }
                              }
                            }

        ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

          BottomButtonIconRow(pageFrom: 'TaskScreenPage',)
      ]
      ),
    );
  }
}
