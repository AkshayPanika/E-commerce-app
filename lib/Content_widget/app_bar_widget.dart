import 'package:flutter/material.dart';
import '../Reusable_widget/text_style_widget.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ///___ Appbar
        ListTile(
          title:  Text("OnShop",style: textStyle17,),
         ///___ Notifications icon
         trailing: const Card(
           shape: OutlineInputBorder(borderSide: BorderSide(color: Colors.black54)),
             child: Padding(
               padding: EdgeInsets.all(8.0),
               child: Icon(Icons.notifications,color: Colors.black54,),
             )) ,
        ),

        ///___ Search bar
         ListTile(
          title: SizedBox(height: 50,
            child: Card(
              shape: const OutlineInputBorder(borderSide: BorderSide(color: Colors.black54)),
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: TextField(
                  style: textStyle15,
                  decoration: InputDecoration(
                      hintText: "Search here...",
                      hintStyle: textStyle15,
                      suffixIcon: const Icon(Icons.search),
                      border: InputBorder.none
                  ),
                ),
              ),
            ),
          ),

           ///___ Shopping cart icon
           trailing: const Card(
               shape: OutlineInputBorder(borderSide: BorderSide(color: Colors.black54)),
               child: Padding(
                 padding: EdgeInsets.all(8.0),
                 child: Icon(Icons.shopping_cart,color: Colors.black54,),
               ))
         ),
        10.height
      ],
    );
  }
}
