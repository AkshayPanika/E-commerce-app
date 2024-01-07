import 'package:ecommerce_app/Screen_view/shopping_page.dart';
import 'package:ecommerce_app/Screen_view/user_data_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'account_page.dart';
import 'favorite_page.dart';
import 'home_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int selectedPage = 0;

  var pageViewList = [ HomePage(),FavoritePage(),ShoppingPage(),
    (FirebaseAuth.instance.currentUser != null) ? UserDataPage():LogInScreen()];//userId:FirebaseAuth.instance.currentUser!.uid,

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:pageViewList[selectedPage],

      bottomNavigationBar:BottomNavigationBar(
        items:const <BottomNavigationBarItem> [
          BottomNavigationBarItem(icon:Icon(Icons.home),label:"Home"),
          BottomNavigationBarItem(icon:Icon(Icons.favorite),label:"Favorite"),
          BottomNavigationBarItem(icon:Icon(Icons.shopping_cart),label:"Shopping"),
          BottomNavigationBarItem(icon:Icon(Icons.account_circle),label:"Account"),
        ],
        unselectedItemColor: Colors.black54,
        selectedItemColor: Colors.black,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        backgroundColor: Colors.red,
        currentIndex: selectedPage,
        onTap: (value){
          setState(() {
            selectedPage = value;
          });
        },
      ),
    );
  }
}
