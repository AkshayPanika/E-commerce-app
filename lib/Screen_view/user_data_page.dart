import 'package:ecommerce_app/Admin_folder/product_home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'account_page.dart';

class UserDataPage extends StatefulWidget {
  const UserDataPage({super.key});

  @override
  State<UserDataPage> createState() => _UserDataPageState();
}

class _UserDataPageState extends State<UserDataPage> {

  void logOutUser()async{
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> LogInScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,elevation: 0,
        actions: [
          TextButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductAddScreen()));
          }, child: const Text("Admin"))
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ///___ User image
                  Container(
                    height: 100,width: 100,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),
                      color: Colors.grey,
                    ),
                    child: const Icon(Icons.person,size: 40,color: Colors.white,),
                  ),

                  ///___ User name
                  const Padding(
                    padding: EdgeInsets.only(top:45,left:15),
                    child: TextWidget(title: "",value: "User name",),
                  ),
                ],
              ),
              SizedBox(height: 20,),
              ///___ User data
              Padding(
                padding: const EdgeInsets.only(left:50.0),
                child: Column(
                  children: [
                    const SizedBox(height:25),
                    const SizedBox(height:10),
                    TextWidget(title: "Phone.  ",value:"${FirebaseAuth.instance.currentUser!.phoneNumber}" ,),
                    const SizedBox(height:10),
                    const TextWidget(title:"Address. ", value:"" ),

                  ],
                ),
              ),
            ],
          ),
          CupertinoButton(
            color: Colors.grey,
            child: Text("Log Out"), onPressed: () {
            logOutUser();
          },)

        ],
      ),
    );
  }
}
class TextWidget extends StatelessWidget {
  final String title;
  final String value;
  const TextWidget({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return   Row(
      children: [
        Text(title,style: const TextStyle(fontSize:19,fontWeight: FontWeight.w500),),
        Text(value,style: const TextStyle(fontSize:19,fontWeight: FontWeight.w500),),
      ],
    );
  }
}

