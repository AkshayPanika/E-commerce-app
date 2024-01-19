import 'package:ecommerce_app/Admin_folder/product_home_page.dart';
import 'package:ecommerce_app/Custom_widget/text_style_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Account_screen/account_page.dart';

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
      backgroundColor: Colors.blueGrey.shade100,
      appBar: AppBar(
        toolbarHeight: 30,
        backgroundColor: Colors.transparent,elevation: 0,
        actions: [
          TextButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductAddScreen()));
          }, child: const Text("Admin"))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(color: Colors.blueGrey.shade100,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ///___ User image
                      Container(
                        height: 80,width: 80,
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
                  20.height,

                  ///___ User data
                  Column(
                    children: [
                      10.height,
                      TextWidget(title: "Phone.  ",value:"${FirebaseAuth.instance.currentUser!.phoneNumber}" ,),
                      const SizedBox(height:10),
                      const TextWidget(title:"Address. ", value:"Waidhan singrauli mp" ),

                    ],
                  ),
                  25.height,
                ],
              ),
            ),
            Expanded(
              child: ListView(
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text("My Order",style: textStyle17,),
                  10.height,
                   const ListTileWidget( text: 'Your Order',),
                   const ListTileWidget( text: 'Card Item',),
                  35.height,

                  ///___ Account settings
                  Text("Account Settings",style: textStyle17,),
                  10.height,
                  const ListTileWidget( text: 'Manage Your Profile',),
                  const ListTileWidget( text: 'Memberships & Subscription',),
                  const ListTileWidget( text: 'Logout',),
                  35.height,

                  ///___ Message Center
                  Text("Message Center",style: textStyle17,),
                  10.height,
                  const ListTileWidget( text: 'Help Center',),
                  const ListTileWidget( text: 'Message Alert',),
                  35.height,

                ],
              ),
            ),
          ],
        ),
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
        Text(title,style: const TextStyle(fontSize:17,fontWeight: FontWeight.w400),),
        Text(value,style: const TextStyle(fontSize:17,fontWeight: FontWeight.w400),),
      ],
    );
  }
}

class ListTileWidget extends StatelessWidget {
  final String text;
  const ListTileWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return  ListTile(
      title: Text(text),shape: const OutlineInputBorder(borderSide: BorderSide(color: Colors.black54)),);
  }
}


