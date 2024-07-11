import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:gas_booking_system/Screens/Admin/Admin%20Connections.dart';
import 'package:gas_booking_system/Screens/Admin/Booking%20Screen.dart';
import 'package:gas_booking_system/Screens/Admin/Search%20Connection.dart';
import 'package:gas_booking_system/Screens/User/Cyclinder%20Booking.dart';
import 'package:gas_booking_system/Service/authenticate.dart';

class booking_details extends StatefulWidget {
  booking_details({required this.Type,required this.Amount,required this.Approved,required this.Name,required this.address,required this.Email,required this.Mobile,required this.ConnectionRefNumber,super.key, required this.uid,});

  final String Type;
  final String Name;
  final String Email;
  final String Mobile;
  final String ConnectionRefNumber;
  final String address;
  final String uid;
  final String Approved;
  final String Amount;
  final DatabaseReference databaseReference =FirebaseDatabase.instance.ref('Bookings');


  @override
  State<booking_details> createState() => _booking_detailsState();
}

class _booking_detailsState extends State<booking_details> {

  String isboolapproved="false";
  String Approved=" ";



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Approved=widget.Approved.toString();
  }

  Future<void> _Approvedialog(BuildContext context){
    final TextEditingController _amountController = TextEditingController();

    Future<void> setAmount () async{
      DatabaseReference databasereference2 = await FirebaseDatabase.instance.ref('Bookings').child(widget.uid);
      databasereference2.ref.update({
        'AmountHasToPay':_amountController.text
      });
      setState(() {
        Approved=widget.Approved.toString();
      });
    }

    return showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        title:Padding(
          padding: EdgeInsets.only(top: 10,left: 10,right: 10,bottom: 10),
          child:Text('Payment')
        ) ,
        content: Padding(
          padding: EdgeInsets.only(top:5,left: 10,right: 10,bottom: 20),
          child: Container(
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Amount User has to pay                           "),
                SizedBox(height: 10,),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: _amountController,
                  decoration: InputDecoration(
                    hintText: 'Amount',
                    border:OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                  ),
                ),
                SizedBox(height: 15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)
                            ),
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.green.shade500
                        ),
                        onPressed: (){
                          setAmount();
                          Navigator.pop(context);
                        },
                        child: const Text('Ok')),
                    SizedBox(width: 10,),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)
                            ),
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.red
                        ),
                        onPressed: (){
                          setAmount();
                          Navigator.pop(context);
                        },
                        child: const Text('Back')),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    });
  }

  Future<void> _declinedialog(BuildContext context){
    return showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        title: Text('Alert !'),
        content: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Are sure you wanted to reject this Booking'),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                          ),
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.green.shade500
                      ),
                      onPressed: (){
                        Navigator.push(context,MaterialPageRoute(builder: (BuildContext)=>booking_list()));
                      },
                      child: const Text('Yes')),
                  SizedBox(width: 10,),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                          ),
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.red.shade500
                      ),
                      onPressed: (){
                        Navigator.push(context,MaterialPageRoute(builder: (BuildContext)=>booking_list()));
                      },
                      child: const Text('No')),
                ],
              )
            ],
          ),
        ),
      );
    });
  }



    Future<void> setApprovedStatus (bool status) async{
      print('start');
      DatabaseReference databasereference2 = await FirebaseDatabase.instance.ref('Bookings').child(widget.uid);
      databasereference2.ref.update({
        'IsApproved':status.toString()
      });
      setState(() {
        Approved=widget.Approved.toString();
      });

      print('success');
    }



  String isApproved="";


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text('Details'),
      ),
      body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 10,),
              Text('Connection Number : ${widget.ConnectionRefNumber}',style: TextStyle(
                  color: Colors.red
              ),),
              Padding(
                padding: EdgeInsets.only(top: 5,right: 15,left: 15),
                child: Card(
                  color: Colors.grey.shade100,
                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Expanded(flex:5,child: Text('Consumer Name    :',style:TextStyle(fontWeight: FontWeight.bold))),
                            Expanded(flex: 5,child: Text(widget.Name))
                          ],
                        ),
                        const SizedBox(height: 15,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(flex:5,child: Text('Registered Mobile  :',style:TextStyle(fontWeight: FontWeight.bold))),
                            Expanded(flex: 5,child: Text(widget.Mobile)),
                          ],
                        ),const SizedBox(height: 15,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(flex:5,child: Text('Gas Type                :',style:TextStyle(fontWeight: FontWeight.bold)),),
                            Expanded(flex: 5,child: Text(widget.Type)),
                          ],
                        ),
                        const SizedBox(height: 15,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(flex:5,child: Text('Shipping Address   :',style:TextStyle(fontWeight: FontWeight.bold)),),
                            Expanded(flex: 5,child: Text(widget.address)),
                          ],
                        ),
                        const SizedBox(height: 15,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(flex:5,child: Text('Status                     :',style:TextStyle(fontWeight: FontWeight.bold)),),
                            Expanded(flex: 5,child: Text(Approved=='true'?'Approved':'Declined',
                              style: TextStyle(color:Approved=='true'?Colors.green:Colors.red),)),
                          ],
                        ),
                        const SizedBox(height: 15,),
                        widget.Amount!='0'?Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(flex:5,child: Text('Amount To Pay       :',style:TextStyle(fontWeight: FontWeight.bold)),),
                            Expanded(flex: 5,child: Text('₹ '+widget.Amount)),
                          ],
                        ):SizedBox(height: 0,),
                        // SizedBox(height: 15,),
                        // widget.Amount!='0'?Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     Expanded(flex:5,child: Text('Payment Status       :',style:TextStyle(fontWeight: FontWeight.bold)),),
                        //     Expanded(flex: 5,child: Text('Unkonwn',style: TextStyle(color: Colors.red),)),
                        //   ],
                        // ):SizedBox(height: 0,)

                      ],
                        ),
                    ),
                  ),
                ),
              const SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                          ),
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.green.shade500
                      ),
                      onPressed: (){
                        FirebaseDatabase.
                        instance.ref('Connections')
                            .child(widget.uid).update({'Is Connection Approved':'approved'}).then((_)
                        {
                          print('Update Succeessfull');
                        });
                        setState(() {
                          isApproved="Approve";
                          setApprovedStatus(true);
                        });
                        _Approvedialog(context);
                      },
                      child: const Text('Approve')),
                  SizedBox(width: 20,),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                          ),
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.red.shade500
                      ),
                      onPressed: (){
                        FirebaseDatabase.
                        instance.ref('Connections')
                            .child(widget.uid).update({'Is Connection Approved':' not approved'}).then((_)
                        {
                          print('Update Succeessfull');
                        });
                        setState(() {
                          setApprovedStatus(false);
                          isApproved="Decline";
                          _declinedialog(context);
                        });
                      },
                      child: const Text('Decline')),
                ],
              ),
            ]
          ),
        ),
    );
  }
}
