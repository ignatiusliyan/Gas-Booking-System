import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:gas_booking_system/Screens/Admin/Dashboard.dart';

import 'Booking Screen.dart';

class details_screen extends StatefulWidget {

  final String Name;
  final String ConnectionNum;
  final String Mobile;
  final String Gender;
  final String MaritalStatus;
  final String Address;
  final String DOB;
  final String uid;
  final String Approved;

  details_screen({required this.Approved,required this.Name,required this.ConnectionNum,super.key,required this.Mobile,required this.Address, required this.Gender, required this.MaritalStatus, required this.DOB, required this.uid});

  @override
  State<details_screen> createState() => _details_screenState();
}

class _details_screenState extends State<details_screen> {
  Future<void> _declinedialog(BuildContext context){
    return showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        title: Text('Alert !'),
        content: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Are sure you wanted to reject this Connection Request'),
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
                        FirebaseDatabase.
                        instance.ref('Connections')
                            .child(widget.uid).update({'Is Connection Approved':' not approved'}).then((_)
                        {
                          print('Update Succeessfull');
                        });
                        Navigator.pop(context);
                      },
                      child: const Text('Yes')),
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
                        Navigator.pop(context);
                        // Navigator.push(context,MaterialPageRoute(builder: (BuildContext)=>booking_list()));
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

  Future<void> _Approvedialog(BuildContext context){
    return showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        title: Text('Alert !'),
        content: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Sure you wanted to Approve the Connection Request'),
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
                        FirebaseDatabase.
                        instance.ref('Connections')
                            .child(widget.uid).update({'Is Connection Approved':'approved'}).then((_)
                        {
                          print('Update Succeessfull');

                        });
                        Navigator.pop(context);
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
                        Navigator.pop(context);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Connection Details',style: TextStyle(
            color: Colors.white
        ),),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Column(
        children: [
          SizedBox(height: 10,),
          Text('Connection Number :${widget.ConnectionNum}',style: TextStyle(
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
                    ),
                    const SizedBox(height: 15,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(flex:5,child: Text('Gender                    :',style:TextStyle(fontWeight: FontWeight.bold)),),
                        Expanded(flex: 5,child: Text(widget.Gender)),
                      ],
                    ),
                    const SizedBox(height: 15,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(flex:5,child: Text('Shipping Address   :',style:TextStyle(fontWeight: FontWeight.bold)),),
                        Expanded(flex: 5,child: Text(widget.Address)),
                      ],
                    ),
                    const SizedBox(height: 15,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(flex:5,child: Text('Date of Birth           :',style:TextStyle(fontWeight: FontWeight.bold)),),
                        Expanded(flex: 5,child: Text(widget.DOB.substring(0,10))),
                      ],
                    ),
                    const SizedBox(height: 15,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(flex:5,child: Text('Marital Status         :',style:TextStyle(fontWeight: FontWeight.bold)),),
                        Expanded(flex: 5,child: Text(widget.MaritalStatus)),
                      ],
                    ),
                    SizedBox(height: 15,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(flex:5,child: Text('Status                     :',style:TextStyle(fontWeight: FontWeight.bold)),),
                        Expanded(flex: 5,child: Text(widget.Approved=='approved'?'Approved':'Declined',
                          style: TextStyle(color:widget.Approved=='approved'?Colors.green:Colors.red),)),
                      ],
                    ),
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
                      backgroundColor: Colors.red
                  ),
                  onPressed: (){
                    _declinedialog(context);
                  },
                  child: const Text('Decline')),
            ],
          )
        ],
      ),
    );
  }
}
