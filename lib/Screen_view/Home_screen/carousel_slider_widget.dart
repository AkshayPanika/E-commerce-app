import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../Custom_widget/text_style_widget.dart';

class CarouselSliderWidget extends StatelessWidget {
  const CarouselSliderWidget({super.key});

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("carouselSlider").snapshots(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.active){
            if(snapshot.hasData && snapshot.data != null){
              return   CarouselSlider.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index, realIndex) {
                  Map<String,dynamic> userMap = snapshot.data!.docs[index].data() as Map<String,dynamic>;

                  ///___ Card widget
                  return   Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(image:NetworkImage(userMap["imageUrl"]),fit: BoxFit.fill
                          ),
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: Colors.black54)
                        ),
                      ),
                      Positioned(
                        bottom: 20,left: 10,
                        child: Card(
                            shape: const OutlineInputBorder(borderSide: BorderSide(color: Colors.black54)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal:15,vertical:3),
                              child: Text(userMap['title'],style: textStyle15,),
                            ))
                      )
                    ],
                  );
                },
                options: CarouselOptions(
                  autoPlay: true,
                  height: 150,
                  disableCenter: true,
                  viewportFraction: 1

                ),

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
    );
  }
}
