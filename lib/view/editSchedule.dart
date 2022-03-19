
import 'package:flutter/material.dart';
import 'package:seeu/helper/constants.dart';
import 'package:seeu/services/database.dart';
import 'schedule.dart';

class EditSchedule extends StatefulWidget {
  const EditSchedule({ Key? key }) : super(key: key);

  @override
  State<EditSchedule> createState() => _EditScheduleState();
}

class _EditScheduleState extends State<EditSchedule> {

 int count=0;
 int count1=0;

  DatabaseMethods databaseMethods=DatabaseMethods();

  static List<GlobalKey<FormState>> formkey = List.empty(growable: true);

  static List<TextEditingController> timeTextEditingController = List.empty(growable: true);
  static List<TextEditingController> eventTextEditingController = List.empty(growable: true);

  static List<String> scheduleTimeList = List.empty(growable: true);
  static List<String> scheduleEventList = List.empty(growable: true);

  createScheduleTimeListFromDataBase() async{
    await databaseMethods.getDocument(Constants.myEmail).then((value){
      count1 = value.data()!["Time"].length;
      for(int i=0 ; i<count1 ; i++){
        scheduleTimeList.add(value.data()!["Time"][i]);
      }
      count=count1;
    });
    setState(() {
    });
  }

   createScheduleEventListFromDataBase() async{
    await databaseMethods.getDocument(Constants.myEmail).then((value){
      int count2 = value.data()!["Event"].length;
      for(int i=0 ; i<count2 ; i++){
        scheduleEventList.add(value.data()!["Event"][i]);
      }
    });
    setState(() {
    });
  }

  updateScheduleToDatabase(){

    List<String> newScheduleTimeList = List.empty(growable: true);
    for(int i=0 ; i<count ; i++){
      newScheduleTimeList.add(timeTextEditingController[i].text);
    }

    List<String> newScheduleEventList = List.empty(growable: true);
    for(int i=0 ; i<count ; i++){
      newScheduleEventList.add(eventTextEditingController[i].text);
    }

    Map<String, dynamic> newScheduleMap = { "Time" : newScheduleTimeList , "Event" : newScheduleEventList};

    databaseMethods.uploadScheduleToDatabase(newScheduleMap, Constants.myEmail);

    for(int i=0 ; i<count ; i++){
      timeTextEditingController[i].text="";
      eventTextEditingController[i].text="";
    }

  }

  clearScheduleLists(){
    scheduleTimeList.clear();
    scheduleEventList.clear();
  }

   @override
  void initState() {
   createScheduleTimeListFromDataBase();
   createScheduleEventListFromDataBase();
    super.initState();
  }  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            clearScheduleLists();
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const Schedule()));
          }, 
          icon: const Icon(Icons.arrow_back)
          ),
        title: const Text("Edit Schedule")),
      
      body: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 100),
            child: ListView.builder(
              itemCount: count,
              itemBuilder: (context,index){
                formkey.add(GlobalKey<FormState>());
                timeTextEditingController.add(TextEditingController(text: scheduleTimeList[index]));
                eventTextEditingController.add(TextEditingController(text: scheduleEventList[index]));
               
                return EditScheduleTile(i : index);
              }
            ),
          ),
          Container(
              alignment: Alignment.bottomCenter,
            
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                height: 100,
                child: Column(
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: (){
                            scheduleTimeList.add("Time...");
                            scheduleEventList.add("Event...");
                            setState(() {
                            count++;
                            });
                          },
                          child: Container(
                            width: 195,
                            height: 45,
                            padding: const EdgeInsets.symmetric(horizontal: 18,vertical: 6),
                            margin: const EdgeInsets.only(right: 7),
                            decoration: BoxDecoration(
                              color: Colors.red[200],
                              borderRadius: BorderRadius.circular(40),
                              border: Border.all(color: const Color(0xFFB71C1C) , width: 1)
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.add,
                                  size: 28,
                                  color: Colors.red[900]
                                ),
                                Text(
                                  "ADD EVENT",
                                  style: TextStyle(
                                    color: Colors.red[900],
                                    fontSize: 22,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            scheduleTimeList.removeLast();
                            scheduleTimeList.removeLast();
                            setState(() {
                              count--;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10 , vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.red[200],
                              borderRadius: BorderRadius.circular(40),
                              border: Border.all(color: const Color(0xFFB71C1C) , width: 1)
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.remove,
                                  color: Colors.red[900],
                                  size: 28,
                                ),
                                Text(
                                  "DELETE EVENT",
                                  style: TextStyle(
                                    color: Colors.red[900],
                                    fontSize: 22,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 6),
                    GestureDetector(
                      onTap: (){
                        clearScheduleLists();
                        updateScheduleToDatabase();
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const Schedule()));
                      },
                      child: Container(
                        height: 45,
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.lightBlue[100],
                          borderRadius: BorderRadius.circular(40),
                          border: Border.all(color: const Color(0xFF006064) , width: 1)
                        ),
                        child: Text(
                          "SAVE CHANGES",
                          style: TextStyle(
                            color: Colors.cyan[800],
                            fontSize: 24,
                            fontWeight: FontWeight.w700
                          ),),
                      ),
                    )
                  ],
                ),
              ),
            ),
          
        ],
        ),
    );
  }
}

class EditScheduleTile extends StatelessWidget {
  final int i;
  const EditScheduleTile({ Key? key , required this.i }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 1, horizontal: 12),
      child: Form(
        key: _EditScheduleState.formkey[i],
        child: Row(
          children: [
            Container(
              //height: 50,
              width: 145,
              margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 4),
              padding: const EdgeInsets.symmetric(horizontal: 6 ),
              decoration: BoxDecoration(
                color : Colors.green[400],
                borderRadius: BorderRadius.circular(40),
              ),
              child: TextFormField(
                controller: _EditScheduleState.timeTextEditingController[i],
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
                
              )
            ),
      
            Container(
              //height: 50,
              width: 230,
              margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
              padding: const EdgeInsets.symmetric(horizontal: 6 ,vertical: 1.2),
              decoration: BoxDecoration(
                color : Colors.lightGreen,
                borderRadius: BorderRadius.circular(40),
              ),
              child: TextFormField( 
                controller : _EditScheduleState.eventTextEditingController[i],
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
                decoration: const InputDecoration(
                  border : InputBorder.none,
                ),
              )
            )
          ],
        ),
      ),
    );
  }
}