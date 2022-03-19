import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:seeu/helper/constants.dart';
import 'package:seeu/services/database.dart';
import 'package:seeu/view/chatlist_view.dart';
import 'package:seeu/view/editSchedule.dart';

class Schedule extends StatefulWidget {
  const Schedule({ Key? key }) : super(key: key);

  @override
  State<Schedule> createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  DatabaseMethods databaseMethods = DatabaseMethods();

  int count1=0;
  int count2=0;

  static List<String> scheduleTime = List.empty(growable: true);

  generateTimeListFromDatabase() async{
    await databaseMethods.getDocument(Constants.myEmail).then((value) {
      count1 = value.data()!["Time"].length;
      print(count1);
      for(int i=0 ; i<count1 ; i++){
        scheduleTime.add(value.data()!["Time"][i]);
      }      
    });
    setState(() {
    });
  }

  static List<String> scheduleEvent = List.empty(growable: true);

  generateEventListFromDatabase() async {
    await databaseMethods.getDocument(Constants.myEmail).then((value) {
    count2 = value.data()!["Event"].length;
      for(int i=0 ; i<count2 ; i++){
        scheduleEvent.add(value.data()!["Event"][i]);
      }
    });
    setState(() {
    });
  }

  @override
  void initState() {
    generateTimeListFromDatabase();
    generateEventListFromDatabase();
    super.initState();
  }

  static clearScheduleLists(){
    scheduleTime.clear();
    scheduleEvent.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon : const Icon(Icons.arrow_back),
          onPressed: (){
            clearScheduleLists();
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const ChatList()));
          },
        ),
        title: const Text("Schedule")),
      body: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 68),
            child: ListView.builder(
            itemCount: count1,
            itemBuilder: (context, index){
              return ScheduleTile(i: index);
            }),
          ),

          Container(
            alignment: Alignment.bottomCenter,
            margin: const EdgeInsets.only(bottom: 16),
            child: GestureDetector(
              onTap: (){
                //clearScheduleLists();
                Navigator.push(context, MaterialPageRoute(builder: (context)=> const EditSchedule()));
              },
              child: Container(
                height: 45,
                padding: const EdgeInsets.symmetric(horizontal : 20 , vertical: 7),
                decoration: BoxDecoration(
                  color: Colors.lightBlue[100],
                  borderRadius: BorderRadius.circular(40),
                  border: Border.all(color: const Color(0xFF006064) , width: 1)),
                child: Text(
                  "EDIT",
                  style: TextStyle(
                    color: Colors.cyan[800],
                    fontSize: 27,
                    fontWeight: FontWeight.w700,
                    ),
                ),
              ),
            ),
          )
        ]
      ),
    );
  }
}

class ScheduleTile extends StatelessWidget {
  final int i;
  const ScheduleTile({ Key? key , required this.i }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 1, horizontal: 12),
      child: Row(
        children: [
          Container(
            //height: 50,
            width: 145,
            margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 4),
            padding: const EdgeInsets.symmetric(horizontal: 6 , vertical: 12),
            decoration: BoxDecoration(
              color : Colors.green[400],
              borderRadius: BorderRadius.circular(40),
            ),
            child: Text(
              _ScheduleState.scheduleTime[i],
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),)
          ),

          Container(
            //height: 50,
            width: 230,
            margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
            padding: const EdgeInsets.symmetric(horizontal: 6 , vertical: 14),
            decoration: BoxDecoration(
              color : Colors.lightGreen,
              borderRadius: BorderRadius.circular(40),
            ),
            child: Text( 
              _ScheduleState.scheduleEvent[i],
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),)
          )
        ],
      ),
    );
  }
}