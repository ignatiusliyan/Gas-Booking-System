import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:gas_booking_system/Screens/User/Payment.dart';
import 'package:gas_booking_system/Service/authenticate.dart';

class booking_history extends StatefulWidget {
  const booking_history({super.key});


  @override
  State<booking_history> createState() => _booking_historyState();
}



class _booking_historyState extends State<booking_history> {

  List<String> BookingDetails =[];
  String Cylindertype='';
  String Name='';
  String BookingId='';
  String Time='';
  String Date='';
  String Mobile='';
  String Email='';
  String Payment='';

  Future<void> fetchbooking () async {
    DatabaseReference ref = FirebaseDatabase.instance.ref('Booking History');
    DatabaseEvent event = await ref.child(FirebaseAuthentication().currentuser()!.uid.toString()).once();
    setState(() {
      Name=event.snapshot.child('Name').value.toString();
      Cylindertype=event.snapshot.child('Gas Type').value.toString();
      BookingId=event.snapshot.child('Booking Id').value.toString();
      Time=event.snapshot.child('Time').value.toString();
      Date=event.snapshot.child('Date').value.toString();
      Mobile=event.snapshot.child('Booking Mobile').value.toString();
      Payment=event.snapshot.child('Payment').value.toString();
      Email=event.snapshot.child('Booked Email').value.toString();
    });
    }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchbooking();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      body:BookingId.isEmpty?Center(child: CircularProgressIndicator()):
      Padding(
        padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
        child: Column(
          children: [
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Booking ID : ',style: TextStyle(
                  color: Colors.red,
                  fontSize: 15
                ),),
                Text(BookingId,style: TextStyle(
                    color: Colors.red
                ),)
              ],
            ),
            SizedBox(height: 10,),
            Container(
              decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black)
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                child: Column(
                 children: [
                  const SizedBox(height: 5,),
                //TODO add the correct history page with valid details like time of booking
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Expanded(flex: 4,child: Text('Cylinder Type          :',style:TextStyle(fontWeight: FontWeight.bold))),
                    Expanded(flex: 6,child: Text(Cylindertype))
                  ],
                ),
                const SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(flex:4,child: Text('Booking Mobile        :',style:TextStyle(fontWeight: FontWeight.bold))),
                    Expanded(flex: 6,child: Text(Mobile),)
                  ],
                ),
                const SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(flex:4,child: Text('Booking Email          :',style:TextStyle(fontWeight: FontWeight.bold)),),
                    Expanded(flex: 6,child: Text(Email),)
                  ],
                ),const SizedBox(height: 10,),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Expanded(flex:4,child: Text('Booking Date           :',style:TextStyle(fontWeight: FontWeight.bold)),),
                       Expanded(flex: 6,child: Text(Date),)
                     ],
                   ),
                   const SizedBox(height: 10,),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Expanded(flex:4,child: Text('Booking Time           :',style:TextStyle(fontWeight: FontWeight.bold)),),
                       Expanded(flex: 6,child: Text(Time),)
                     ],
                   ),
                   const SizedBox(height: 10,),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Expanded(flex:4,child: Text('Payment Status       :',style:TextStyle(fontWeight: FontWeight.bold)),),
                       Expanded(flex: 6,child: Text(Payment),)
                     ],
                   ),
                 ],
                ),
              ),
            )
          ],
        ),
      )
    );
  }
}
