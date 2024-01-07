import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../Reusable_widget/text_style_widget.dart';
import 'carousel_slider_upload.dart';
import 'new_arrivals_upload.dart';

class ProductAddScreen extends StatefulWidget {
  const ProductAddScreen({super.key});

  @override
  State<ProductAddScreen> createState() => _ProductAddScreenState();
}

class _ProductAddScreenState extends State<ProductAddScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade100,
      appBar: AppBar(
        title:  Text("Admin",style: textStyle17,),
        backgroundColor: Colors.transparent,elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [

          PopupMenuButton(itemBuilder: (context) => [

            ///___ Carousel Slider button
            PopupMenuItem(child:const Text("Carousel Slider"),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> const CarouselSliderUpload()));
            },
            ),

            ///___ New Arrivals button
             PopupMenuItem(child:const Text( "New Arrivals",),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>  NewArrivalUpload()));
              },
            ),
          ],)
        ],
      ),

      ///___ Body
      body:  Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 15),
              child: Text("Carousel Slider ",style: textStyle17,),
            ),

            ///___ Carousel slider list 
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection("carouselSlider").snapshots(),
              builder: (context, snapshot) {
                if(snapshot.connectionState == ConnectionState.active){
                  if(snapshot.hasData && snapshot.data != null){
                    return   SizedBox(
                      height: 150,
                      child: ListView.builder(
                        itemCount:snapshot.data!.docs.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          Map<String,dynamic> userMap = snapshot.data!.docs[index].data() as Map<String,dynamic>;

                          return Card(
                            shape: const OutlineInputBorder(borderSide: BorderSide(color: Colors.black54)),
                            child: Stack(
                              children: [
                                Image.network(userMap["imageUrl"],fit: BoxFit.fill,),

                                ///___ delete button
                                Positioned(
                                  right: -5,top: -5,
                                    child: InkWell(
                                      onTap: ()async{
                                        await FirebaseFirestore.instance.collection("carouselSlider").doc(snapshot.data!.docs[index].id).delete();

                                      },
                                        child: const Card(
                                            shape: OutlineInputBorder(borderSide: BorderSide(color: Colors.black54)),
                                            child: Icon(Icons.delete,color: Colors.black54,)))),

                                ///___ Text headline
                                Positioned(
                                    bottom: 20,left: 15,
                                    child: Text(userMap['title'],style: textStyle17,)),
                              ],
                            ),
                          );
                        },),
                    );
                  }
                  else{
                    return const Center(child: Text("No data!"));
                  }
                }
                else{
                  return const Center(child: CircularProgressIndicator(color: Colors.black,),);
                }
              },),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 15),
              child: Text(
                "New Arrivals",
                style: textStyle17,
              ),
            ),
            
            ///___ New arrivals list
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection("newArrivals").snapshots(),
                builder: (context, snapshot) {
                  if(snapshot.connectionState == ConnectionState.active){
                    if(snapshot.hasData && snapshot.data != null){
                      return MasonryGridView.builder(
                        itemCount:snapshot.data!.docs.length,
                        //physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),

                        itemBuilder: (context, index) {
                          Map<String,dynamic> userMap = snapshot.data!.docs[index].data() as Map<String,dynamic>;

                          return InkWell(
                            child: Card(
                              shape: const OutlineInputBorder(borderSide: BorderSide(color: Colors.black54)),
                              child: Stack(
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Image.network(userMap["imageUrl"]),

                                      ///___ Image collection
                                      StreamBuilder<QuerySnapshot>(
                                          stream: FirebaseFirestore.instance.collection("newArrivals").doc().collection("imageCollection").snapshots(),
                                          builder:(context, snapshot) {
                                           if(snapshot.connectionState == ConnectionState.active){
                                              if(snapshot.hasData && snapshot.data != null){
                                                return   SizedBox(height:50,
                                                  child: ListView.builder(
                                                    itemCount:snapshot.data!.docs.length,
                                                    scrollDirection: Axis.horizontal,
                                                    itemBuilder: (context, index) {
                                                      Map<String,dynamic> userMap = snapshot.data!.docs[index].data() as Map<String,dynamic>;
                                                      return  Card(
                                                        shape:  const OutlineInputBorder(borderSide: BorderSide(color: Colors.black54)),
                                                        child: Image.network(userMap["imageUrl"]),
                                                      );
                                                    },),
                                                );
                                              }
                                              else{
                                                return   const Text("No data!");
                                              }
                                           }
                                           else{
                                             return const Center(child: CircularProgressIndicator(color: Colors.black,),);
                                           }

                                        },
                                      ),

                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(userMap['title'],style: textStyle15,),
                                            Row(
                                              children: [
                                                Text("price.  ${userMap['initialPrice'].toString()}",style: textStyle15),
                                                const Icon(Icons.currency_rupee,size:15,)
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),

                                  ///___ Ratting
                                  Positioned(
                                      bottom: 25,right: 10,
                                      child: Row(children: [
                                        Text(userMap['ratting'].toString()),
                                        const Icon(Icons.star,color: Colors.amber,size: 20,),
                                      ],)),
                                  ///___ Delete icon
                                  Positioned(
                                    right: -5,top: -5,
                                    child: InkWell(
                                      child: const Card(
                                        shape: OutlineInputBorder(borderSide: BorderSide(color: Colors.black54)),
                                        child: Padding(
                                          padding: EdgeInsets.all(2.0),
                                          child: Icon(
                                            Icons.delete,
                                            color: Colors.black54,
                                          ),
                                        ),
                                      ),
                                      onTap: ()async{
                                        await FirebaseFirestore.instance.collection("newArrivals").doc(snapshot.data!.docs[index].id).delete();
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }
                    else{
                      return const Center(child: Text("No data!"));
                    }
                  }
                  else{
                    return const Center(child: CircularProgressIndicator(color: Colors.black,),);
                  }

                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

