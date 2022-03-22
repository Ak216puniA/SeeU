
import 'package:flutter/material.dart';
import 'package:seeu/helper/sharedPreference_functions.dart';
import 'package:seeu/view/createSchedule.dart';

class NoSchedule extends StatefulWidget {
  const NoSchedule({ Key? key }) : super(key: key);

  @override
  State<NoSchedule> createState() => _CreateScheduleState();
}

class _CreateScheduleState extends State<NoSchedule> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Scheduler")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Donot Have",
              style: TextStyle(
                color: Colors.green,
                fontSize: 50,
                fontWeight: FontWeight.w600

              ), ),
              const SizedBox(height: 6),
              const Text(
              "Schedule ?",
              style: TextStyle(
                color: Colors.lightGreen,
                fontSize: 38,
                fontWeight: FontWeight.w500
                
              ), ),
            
            GestureDetector(
              onTap: (){
                SharedPreference_Functions.saveSchedulerCreatedOnceSharedPreference(false);
                Navigator.push(context, MaterialPageRoute(builder: (context) => const CreateSchedule()));
              },
              child: Container(
                margin: const EdgeInsets.only(top: 20),
                height: 80,
                width: 200,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF4CAF50),
                      Color(0xFF8BC34A)
                    ]),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: const Center(
                  child: Text(
                    "Create One !",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                    ),
                    )),
              ),
            )
          ],
        ),
      ),
      
    );
  }
}