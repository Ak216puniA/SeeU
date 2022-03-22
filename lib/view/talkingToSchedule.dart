import 'package:flutter/material.dart';
import 'package:seeu/services/database.dart';

class TalkingtoSchedule extends StatefulWidget {
  final String talkingTo;
  const TalkingtoSchedule({ Key? key , required this.talkingTo}) : super(key: key);

  @override
  State<TalkingtoSchedule> createState() => _TalkingtoScheduleState();
}

class _TalkingtoScheduleState extends State<TalkingtoSchedule> {
  DatabaseMethods databaseMethods = DatabaseMethods();

  int count=0;

  static List<String> talkingToTimeList = List.empty(growable: true);

  static List<String> talkingToEventList = List.empty(growable: true);

  createTalkingToTimeListFromDatabase() async{
    await databaseMethods.getUserByUsername(widget.talkingTo).then((value){
      int count1 = value.docs[0].data()["Time"].length;
      for(int i=0 ; i<count1 ; i++){
        talkingToTimeList.add(value.docs[0].data()["Time"][i]);
      count = count1;
      }
    });
    setState(() {
      
    });
  }

  createTalkingToEventListFromDatabase() async{
    await databaseMethods.getUserByUsername(widget.talkingTo).then((value){
      int count2 = value.docs[0].data()["Event"].length;
      for(int i=0 ; i<count2 ; i++){
        talkingToEventList.add(value.docs[0].data()["Event"][i]);
      }
    });
    setState(() {
      
    });
  }

  @override
  void initState() {
    talkingToTimeList.clear();
    talkingToEventList.clear();
    createTalkingToTimeListFromDatabase();
    createTalkingToEventListFromDatabase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.talkingTo+"'s Schedule"),
      ),
      body: ListView.builder(
        itemCount: count,
        itemBuilder: (context,index){
          return TalkingToScheduleTile(i:index);
        }),      
    );
  }
}

class TalkingToScheduleTile extends StatelessWidget {
  final int i;
  const TalkingToScheduleTile({ Key? key , required this.i }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 1, horizontal: 12),
      child: Row(
        children: [
          Container(
            width: 145,
            margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 4),
            padding: const EdgeInsets.symmetric(horizontal: 6 , vertical: 12),
            decoration: BoxDecoration(
              color : Colors.green[400],
              borderRadius: BorderRadius.circular(40),
            ),
            child: Text(
              _TalkingtoScheduleState.talkingToTimeList[i],
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),)
          ),
          Container(
            width: 230,
            margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
            padding: const EdgeInsets.symmetric(horizontal: 6 , vertical: 14),
            decoration: BoxDecoration(
              color : Colors.lightGreen,
              borderRadius: BorderRadius.circular(40),
            ),
            child: Text( 
              _TalkingtoScheduleState.talkingToEventList[i],
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