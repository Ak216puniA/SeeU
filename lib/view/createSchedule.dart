import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:seeu/helper/constants.dart';
import 'package:seeu/helper/sharedPreference_functions.dart';
import 'package:seeu/services/database.dart';
import 'package:seeu/view/schedule.dart';

class CreateSchedule extends StatefulWidget {
  const CreateSchedule({ Key? key }) : super(key: key);

  @override
  State<CreateSchedule> createState() => _CreateScheduleState();
}

class _CreateScheduleState extends State<CreateSchedule> {

  int count = 1;

  DatabaseMethods databaseMethods=DatabaseMethods();
  
  //static final formkey = GlobalKey<FormState>();
  static List<GlobalKey<FormState>> formkey = List.empty(growable: true);

  static List<TextEditingController> timeTextEditingController = List.empty(growable: true);
  static List<TextEditingController> eventTextEditingController = List.empty(growable: true);

  /*Widget ScheduleTile({required int i}){
    
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      child: Form(
        key: formkey,
        child: Row(
          children: [
            Container(
              height: 50,
              width: 120,
              margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
              padding: const EdgeInsets.symmetric(horizontal: 6 , vertical: 6),
              decoration: BoxDecoration(
                color : Colors.green,
                borderRadius: BorderRadius.circular(40),
              ),
              child: TextFormField(
                controller: timeTextEditingController[i],
                decoration: const InputDecoration(
                  hintText: "Time...",
                  hintStyle: TextStyle(
                  color: Colors.white70,
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  ),
                            
                   border: InputBorder.none
                ),
                            
              ),
            ),

            Container(
               height: 50,
              width: 235,
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              padding: const EdgeInsets.symmetric(horizontal: 6 , vertical: 6),
              decoration: BoxDecoration(
                color : Colors.lightGreen,
                borderRadius: BorderRadius.circular(40),
              ),
              child: TextFormField(
                controller: eventTextEditingController[i],
                decoration: const InputDecoration(
                  hintText: "Event...",
                  hintStyle: TextStyle(
                  color: Colors.white70,
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  ),
                            
                   border: InputBorder.none
                ),
                            
              ),
            )
          ],
        ),
      ),
    );
  }*/

  createScheduleToDatabase() async {

    List<String> timeList = List.filled(1, timeTextEditingController[0].text, growable: true);
    for(int i=1 ; i<count ; i++){
      timeList.add(timeTextEditingController[i].text);
    }

    List<String> eventList = List.filled(1, eventTextEditingController[0].text, growable: true);
    for(int i=1 ; i<count ; i++){
      eventList.add(eventTextEditingController[i].text);
    }

    Map<String, dynamic> scheduleMap = { "Time" : timeList , "Event" : eventList};

    Constants.myEmail = await SharedPreference_Functions.getUserEmailSharedPreference() as String;

    await databaseMethods.uploadScheduleToDatabase(scheduleMap, Constants.myEmail);

    for(int i=0 ; i<count ; i++){
      timeTextEditingController[i].text="";
      eventTextEditingController[i].text="";
    }

  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Create Schedule for the First time !"),),
      body: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 68),
            child: ListView.builder(
            itemCount: count,
            itemBuilder: (context,index){
              formkey.add(GlobalKey<FormState>());
              timeTextEditingController.add(TextEditingController());
              eventTextEditingController.add(TextEditingController());
              return CreateScheduleTile(i : index);
            }
            ),
          ),

          Container(
            alignment: Alignment.bottomCenter,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: Row(
              children: [
                GestureDetector(
                  onTap: (){
                    setState(() {
                      count++;
                    });
                  },
                  child: Container(
                    height: 45,
                    margin: const EdgeInsets.only(left: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.red[100],
                      borderRadius: BorderRadius.circular(40),
                      border: Border.all(color: const Color(0xFFB71C1C) , width: 1)
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.add,
                          size: 35,
                          color: Colors.red[900],),
                        const Text(
                          "ADD EVENT",
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 27,
                            fontWeight: FontWeight.w600,
                          )),    
                      ],),
                  ),
                ),

                const SizedBox(width: 30),

                GestureDetector(
                onTap: (){
                  createScheduleToDatabase();
                  SharedPreference_Functions.saveSchedulerCreatedOnceSharedPreference(true);
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Schedule()));
                },
                  child: Container(
                    height: 45,
                    padding: const EdgeInsets.symmetric(horizontal : 20 , vertical: 7),
                    decoration: BoxDecoration(
                      color: Colors.lightBlue[100],
                      borderRadius: BorderRadius.circular(40),
                      border: Border.all(color: const Color(0xFF006064) , width: 1)),
                    child: Text(
                      "DONE !",
                      style: TextStyle(
                        color: Colors.cyan[800],
                        fontSize: 27,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                )
              ],
            ),
          )        
        ]),
      
    );
  }
}

/*class ScheduleTile extends StatefulWidget {
  const ScheduleTile({ Key? key }) : super(key: key);

  @override
  State<ScheduleTile> createState() => _ScheduleTileState();
}

class _ScheduleTileState extends State<ScheduleTile> {

  final formkey = GlobalKey<FormState>();

  TextEditingController timeTextEditingController = TextEditingController();
  TextEditingController eventTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      child: Form(
        key: formkey,
        child: Row(
          children: [
            Container(
              height: 50,
              width: 120,
              margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
              padding: const EdgeInsets.symmetric(horizontal: 6 , vertical: 6),
              decoration: BoxDecoration(
                color : Colors.green,
                borderRadius: BorderRadius.circular(40),
              ),
              child: TextFormField(
                controller: timeTextEditingController,
                decoration: const InputDecoration(
                  hintText: "Time...",
                  hintStyle: TextStyle(
                  color: Colors.white70,
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  ),
                            
                   border: InputBorder.none
                ),
                            
              ),
            ),

            Container(
               height: 50,
              width: 235,
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              padding: const EdgeInsets.symmetric(horizontal: 6 , vertical: 6),
              decoration: BoxDecoration(
                color : Colors.lightGreen,
                borderRadius: BorderRadius.circular(40),
              ),
              child: TextFormField(
                controller: eventTextEditingController,
                decoration: const InputDecoration(
                  hintText: "Event...",
                  hintStyle: TextStyle(
                  color: Colors.white70,
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  ),
                            
                   border: InputBorder.none
                ),
                            
              ),
            )
          ],
        ),
      ),
      
    );
  }
}*/

class CreateScheduleTile extends StatelessWidget {
  final int i;
  const CreateScheduleTile({ Key? key , required this.i}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 1, horizontal: 12),
      child: Form(
        key: _CreateScheduleState.formkey[i],
        child: Row(
          children: [
            Container(
              height: 50,
              width: 120,
              margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
              padding: const EdgeInsets.symmetric(horizontal: 6 , vertical: 6),
              decoration: BoxDecoration(
                color : Colors.green[400],
                borderRadius: BorderRadius.circular(40),
              ),
              child: TextFormField(
                controller: _CreateScheduleState.timeTextEditingController[i],
                decoration: const InputDecoration(
                  hintText: "Time...",
                  hintStyle: TextStyle(
                  color: Colors.white70,
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  ),
                            
                   border: InputBorder.none
                ),
                            
              ),
            ),

            Container(
               height: 50,
              width: 235,
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              padding: const EdgeInsets.symmetric(horizontal: 6 , vertical: 6),
              decoration: BoxDecoration(
                color : Colors.lightGreen,
                borderRadius: BorderRadius.circular(40),
              ),
              child: TextFormField(
                controller: _CreateScheduleState.eventTextEditingController[i],
                decoration: const InputDecoration(
                  hintText: "Event...",
                  hintStyle: TextStyle(
                  color: Colors.white70,
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  ),
                            
                   border: InputBorder.none
                ),
                            
              ),
            )
          ],
        ),
      ),
    );
  }
}