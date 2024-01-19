import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/Custom_widget/cart_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../../Custom_widget/text_style_widget.dart';
import '../Details_screen/details_screen.dart';

class NewArrivalProductList extends StatefulWidget {
  const NewArrivalProductList({super.key});

  @override
  State<NewArrivalProductList> createState() => _NewArrivalProductListState();
}

class _NewArrivalProductListState extends State<NewArrivalProductList> {
  bool isFavorite=false;
  bool toTap=false;

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Text("New Arrivals", style: textStyle17,),
          10.height,

          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection("newArrivals").snapshots(),
              builder: (context, snapshot) {
              if(snapshot.connectionState == ConnectionState.active){
                if(snapshot.hasData && snapshot.data != null){
                  return MasonryGridView.builder(
                    itemCount:snapshot.data!.docs.length,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemBuilder: (context, index) {
                      Map<String,dynamic> userMap = snapshot.data!.docs[index].data() as Map<String,dynamic>;

                      return InkWell(
                        child: CardWidget(
                          child: Stack(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                 ClipRRect(
                                      borderRadius: BorderRadius.circular(3),
                                      child: Image.network(userMap["imageUrl"])),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        5.height,
                                        Text(userMap['title'],style: textStyle15),
                                        Row(
                                          children: [
                                            Text("Price.${userMap['initialPrice']}",style: textStyle15),
                                            const Icon(Icons.currency_rupee,size: 15,)
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),

                               ///___ Ratting star logo
                               Positioned(
                                  bottom: 16,right: 5,
                                  child: Row(children: [
                                Text(userMap['ratting'].toString()),
                                const Icon(Icons.star,color: Colors.amber,size: 20,),
                              ],)),

                              ///___ Favorite border icon
                                Positioned(
                                right: -5,top: -5,
                                child: CardWidgetWithPadding(
                                  padding: 5,
                                    child: InkWell(
                                      onTap: (){ },
                                      child:Icon(Icons.favorite,size: 25,color:Colors.grey) )
                                )
                              )
                            ],
                          ),
                        ),
                       onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) =>   DetailsPage(
                                image: userMap["imageUrl"],
                                title: userMap["title"],
                                price: userMap["initialPrice"],
                                ratting: userMap["ratting"],
                              )));
                        },
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
          )
        ],
      ),
    );
  }
}
