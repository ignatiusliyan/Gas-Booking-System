import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:gas_booking_system/Screens/User/Dashboard.dart';
import 'package:gas_booking_system/Screens/User/payment%20Options.dart';

import '../../Service/authenticate.dart';

final DatabaseReference databaseReference =
FirebaseDatabase.instance.ref('Connections');

class cylinder_booking extends StatefulWidget {
  cylinder_booking({super.key});





  @override
  State<cylinder_booking> createState() => _cylinder_bookingState();
}


class _cylinder_bookingState extends State<cylinder_booking> {

  String dropdownvalue = 'Select Gas';
  var items = [
    'Select Gas',
    'LPG 5KG',
    'LPG 14.2KG'
  ];

  List<String> personaldataList = [];
  // List<String> connectionRef = [];
  String connectionRefNumber = '';

  String ConnectionapprovalStatus='';
  String amount='';
  String BookingApprovalStatus='';

  String name='';
  String mobile='';
  String email='';
  String address='';
  String gasType='';


  String Bookingid = user_dashboard.generateUniqueId();

  Future<void> fetchApprovalStatus()async{
    DatabaseReference reference =FirebaseDatabase.instance.ref('Bookings');
    DatabaseReference reference1 =FirebaseDatabase.instance.ref('Connections');
    DatabaseEvent event=await reference.child(FirebaseAuthentication().currentuser()!.uid.toString()).once();
    DatabaseEvent event1=await reference1.child(FirebaseAuthentication().currentuser()!.uid.toString()).once();
    amount=event.snapshot.child('AmountHasToPay').value.toString();
    BookingApprovalStatus=event.snapshot.child('IsApproved').value.toString();
    ConnectionapprovalStatus=event1.snapshot.child('Is Connection Approved').value.toString();
    gasType=event.snapshot.child('Gas Type').value.toString();

  }

  void fetchPersonalData() async {
    try {
      DatabaseEvent snapshot2 =await databaseReference.child(FirebaseAuthentication().currentuser()!.uid.toString()).child('Connection Ref Number').once();
      DatabaseEvent snapshot1 = await databaseReference.child(FirebaseAuthentication().currentuser()!.uid.toString()).child('Personal Details').once();
      setState(() {
        name=snapshot1.snapshot.child('Name').value.toString();
        mobile=snapshot1.snapshot.child('Phone').value.toString();
        email=snapshot1.snapshot.child('Email').value.toString();
        address=snapshot1.snapshot.child('Address').value.toString();
        print(snapshot2.snapshot.value.toString());
        connectionRefNumber=snapshot2.snapshot.value.toString();
      });
    } catch (e) {
      print("Error fetching data: $e");
      // Handle the exception as needed
    }
  }

  @override
  void initState() {
    super.initState();
    fetchPersonalData();
    fetchApprovalStatus();

    print('C'+connectionRefNumber);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text('Cylinder Booking',
          style: TextStyle(
              color: Colors.white
          ),),
      ),
      body: connectionRefNumber.isEmpty?Center(child: CircularProgressIndicator()):Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 15,),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Book Your Cylinder',
                style:TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                ) ,),
            ],
          ),
          const SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Connection Number :',style:TextStyle(color: Theme.of(context).colorScheme.primary)),
              Text(' '+connectionRefNumber.toString(),style: TextStyle(color: Theme.of(context).colorScheme.primary),),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black)
              ),
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 5,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Expanded(flex:4,child: Text('Consumer Name    :',style:TextStyle(fontWeight: FontWeight.bold))),
                      Expanded(flex: 6,child: Text(name))
                    ],
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(flex:4,child: Text('Registered Mobile  :',style:TextStyle(fontWeight: FontWeight.bold))),
                      Expanded(flex: 6,child: Text(mobile)),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(flex:4,child: Text('Consumer Email     :',style:TextStyle(fontWeight: FontWeight.bold)),),
                      Expanded(flex: 6,child: Text(email)),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(flex:4,child: Text('Shipping Address   :',style:TextStyle(fontWeight: FontWeight.bold)),),
                      Expanded(flex: 6,child: Text(address)),
                    ],
                    //TODO Cylinder Type
                  ),
                  const SizedBox(height: 10,),
                  ConnectionapprovalStatus=="approved"
                      ?BookingApprovalStatus=="false"?Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(flex:4,child: Text('Gas Type                :',style:TextStyle(fontWeight: FontWeight.bold)),),
                      Expanded(flex: 6,child: DropdownButton(

                        // Initial Value
                        value: dropdownvalue,

                        // Down Arrow Icon
                        icon: const Icon(Icons.keyboard_arrow_down),

                        // Array list of items
                        items: items.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items),
                          );
                        }).toList(),
                        // After selecting the desired option,it will
                        // change button value to selected value
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownvalue = newValue!;
                          });
                        },
                      ),),
                    ],
                    //TODO Cylinder Type
                  ):Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(flex:4,child: Text('Gas Type                :',style:TextStyle(fontWeight: FontWeight.bold)),),
                      Expanded(flex: 6,child: Text(gasType)),
                    ],
                  ):const SizedBox(height: 0.0,),
                  const SizedBox(height: 10,),
                  BookingApprovalStatus!=''?Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(flex:4,child: Text('Booking Status       :',style:TextStyle(fontWeight: FontWeight.bold)),),
                      Expanded(flex: 6,child: Text(BookingApprovalStatus=='true'?'Approved':'Declined',
                        style: TextStyle(color:BookingApprovalStatus=='true'?Colors.green:Colors.red),)),
                    ],
                  ):SizedBox(height: 0,),
                  const SizedBox(height: 10,),
                  amount!="0"?Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(flex:4,child: Text('Amount To Pay       :',style:TextStyle(fontWeight: FontWeight.bold)),),
                      Expanded(flex: 6,child: Text('₹ '+amount)),
                    ],
                  ):SizedBox(height: 0,)
                ],
              ),
            ),

          ),ConnectionapprovalStatus!="approved"?Center(child: Text('Your Connection Request is not Approved',style: TextStyle(color: Colors.red,fontSize: 14),),):
          BookingApprovalStatus=="false"?ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                  ),
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.red
              ),
              onPressed: (){
                FirebaseDatabase.instance.ref("Bookings")
                    .child(FirebaseAuthentication().currentuser()!.uid.toString())
                    .update({
                      'Name':name,
                      'Gas Type':dropdownvalue,
                      'Mobile':mobile,
                      'Email':email,
                      'Shipping Adddress':address,
                      'Connection Ref Number':connectionRefNumber,
                     });
                FirebaseDatabase.instance.ref("Booking History")
                    .child(FirebaseAuthentication().currentuser()!.uid.toString())
                    .update({
                  'Booking Id':Bookingid.toString(),
                  'Gas Type':dropdownvalue,
                  'Date':getCurrentDate(),
                  'Time':getCurrentTime(),
                  'Booking Mobile':mobile,
                  'Booked Email':email,
                  'Payment':'Pending'
                });
                // FirebaseDatabase.instance.ref("Bookings")
                //     .child(FirebaseAuthentication().currentuser()!.uid.toString())
                //     .update({
                //   'Connection Ref Number':connectionRefNumber,
                // });
                if(dropdownvalue=='Select Gas'){
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        duration: const Duration(seconds: 3),
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        content: Text('Select Gas Type',style: TextStyle(color: Theme.of(context).colorScheme.background),),
                      )
                  );
                }else{

                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext)=>user_dashboard()));
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        duration: const Duration(seconds: 3),
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        content: Text('Cylinder Booking Request send successfully',style: TextStyle(color: Theme.of(context).colorScheme.background),),
                      )
                  );

                }

                },
              child: const Text('Book'))
              :ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                  ),
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.red
              ),
              onPressed: (){

                Navigator.pushReplacement(context,MaterialPageRoute(builder: (BuildContext)=>patmentOption()));
              },
              child: const Text('Pay Now'))

        ],
      ),
    );
  }
  static String getCurrentDate() {
    DateTime now = DateTime.now();
    String formattedDate = "${now.year}-${_formatTwoDigits(now.month)}-${_formatTwoDigits(now.day)}";
    return formattedDate;
  }

  static String getCurrentTime() {
    DateTime now = DateTime.now();
    String formattedTime = "${_formatTwoDigits(now.hour)}:${_formatTwoDigits(now.minute)}:${_formatTwoDigits(now.second)}";
    return formattedTime;
  }

  static String _formatTwoDigits(int num) {
    return num < 10 ? '0$num' : num.toString();
  }
}
