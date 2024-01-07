import 'package:ecommerce_app/Provider_folder/card_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import '../Reusable_widget/text_style_widget.dart';
import 'main_page.dart';

class DetailsPage extends StatefulWidget {
  final String image;
  final String title;
  final double price;
  final double ratting;
  const DetailsPage({super.key, required this.image, required this.title, required this.price, required this.ratting,});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {

  bool isFavorite=false;
  bool toTap=false;

  int selectSizeIndex=0;
  List selectedSizeName=['S','M','L','XL','XXL'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade100,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SafeArea(
          child: Column(
            children: [
              ///___ App bar
              ListTile(
                leading: InkWell(
                  onTap: () { Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const MainPage()));
                  }, child: const Card(
                    shape: OutlineInputBorder(borderSide: BorderSide(color: Colors.black54)),
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.arrow_back,color: Colors.black54,),
                    ))
                ),
                title:  Text("Product name",style:textStyle17),
                trailing: const Card(
                    shape: OutlineInputBorder(borderSide: BorderSide(color: Colors.black54)),
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.shopping_cart,color: Colors.black54,),
                    )),
              ),

              ///___ Body
              Expanded(
                child: ListView(
                  children: [
                    ///___ Image container
                    Stack(
                      children: [
                        Container(
                          height:350,
                          width: double.infinity,
                          margin: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              image: DecorationImage(
                                image: NetworkImage(widget.image),
                              ),
                              border: Border.all(color: Colors.black54)
                          ),
                        ),

                         ///___ Favorite
                         Positioned(
                            right: 20,
                            bottom: 20,
                            child: InkWell(
                                onTap: ()async{
                                  if(isFavorite){
                                    isFavorite=false;
                                  }
                                  else{
                                    isFavorite=true;
                                  }
                                  if(toTap)return;
                                  setState(() {
                                    toTap=true;
                                  });

                                  await Future.delayed(const Duration(milliseconds: 300));
                                  setState(() {
                                    toTap=false;
                                  });
                                },
                                child:toTap?SizedBox(height:25,width:25,child: CircularProgressIndicator(color: Colors.black54,backgroundColor: Colors.red,)): isFavorite? Icon(Icons.favorite,size: 32,color: Colors.red,):
                                Icon(Icons.favorite_border,size: 32,color: Colors.black54,)
                            )),

                      ],
                    ),

                    ///___ Image container list
                    SizedBox(
                      height: 80,
                      child: ListView.builder(
                        itemCount: 5,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Container(
                            height: 100,width: 100,
                            margin: const EdgeInsets.symmetric(horizontal:5,vertical:2),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: Colors.black54)
                            ),
                          );
                        },),
                    ),


                     Padding(
                       padding:  const EdgeInsets.all(8.0),
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [

                           ///__ Name + Price + Ratting
                           Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                               Row(
                                 children: [
                                   ///___ Title
                                   Text(widget.title,style:textStyle15),
                                   10.width,
                                   Text("${widget.price}",style:textStyle15),
                                   const Icon(Icons.currency_rupee,size: 15,)
                                 ],
                               ),
                               ///___ Ratting
                               Row(
                                 children: [
                                   Text("${widget.ratting}",style:textStyle15),
                                   const Icon(Icons.star,color: Colors.amber,size: 20,)
                                 ],
                               )
                             ],
                           ),

                           ///___ Color list
                           15.height,
                           Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Text("Color",style:textStyle15),
                               5.height,
                               SizedBox(
                                 height: 30,
                                 child: ListView.builder(
                                   itemCount: 5,
                                   scrollDirection: Axis.horizontal,
                                   itemBuilder: (context, index) {
                                     return const CircleAvatar(
                                       backgroundColor: Colors.black54,
                                       child: CircleAvatar(
                                         radius: 12,backgroundColor: Colors.white,
                                       ),
                                     );
                                   },),
                               ),
                             ],
                           ),


                           ///___ Size list
                           15.height,
                           Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Text("Size",style: textStyle15),
                               5.height,

                               ///___ Size list
                               SizedBox(
                                 height: 40,
                                 child: ListView.builder(
                                   itemCount: selectedSizeName.length,
                                   scrollDirection: Axis.horizontal,
                                   itemBuilder: (context, index) {
                                     return InkWell(
                                       onTap: (){
                                         setState(() {
                                           selectSizeIndex=index;
                                         });
                                       },
                                       child:  Card(
                                         color: selectSizeIndex == index? Colors.black54: Colors.grey,
                                         shape: const OutlineInputBorder(borderSide: BorderSide(color: Colors.black54)),
                                         child: SizedBox(width: 50,
                                           child: Center(child: Text(selectedSizeName[index],style: TextStyle(color:  selectSizeIndex == index? Colors.white: Colors.black,),),
                                           ),
                                         ),
                                       ),
                                     );
                                   },),
                               ),
                             ],
                           ),


                           15.height,
                           const Text("Description",style: TextStyle(fontSize:15,color: Colors.black),),
                          const ReadMoreText(
                          'Flutter is Google’s mobile UI open source framework to build high-quality native (super fast) interfaces for iOS and Android apps with the unified codebase.',
                          trimLines: 2,
                          colorClickableText: Colors.pink,
                          trimMode: TrimMode.Line,
                          trimCollapsedText: 'Show more',
                          trimExpandedText: 'Show less',
                          moreStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold,color: Colors.red),
                          lessStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold,color: Colors.red),
                        )
                         ],
                       ),
                     ),
                    10.height,

                  ],
                ),
              ),

              ///___ Add to cart
              Container(
                height: 55,
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                 // color: Colors.black,
                  border: Border.all(color: Colors.black54),
                ),

                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("____ Price",style: textStyle17),
                      InkWell(
                        child: Card(
                          shape: const OutlineInputBorder(borderSide: BorderSide(color: Colors.black54)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15,vertical:5),
                            child: Row(
                              children: [
                                Text("Add to cart",style: textStyle17),
                                const Icon(Icons.shopping_cart,color: Colors.black54,)
                              ],
                            ),
                          ),
                        ),
                       onTap: () {

                       },
                       /* onTap: (){
                         var  data = NewArrivalModels(imageUrl: widget.image, title: widget.title, initialPrice: widget.price, ratting: widget.ratting);
                          FirebaseFirestore.instance.collection("user").doc().collection("productAddToCart").add(data.toMap());
                         const snackBar = SnackBar(
                           content: Text("Product is added to cart",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 19)),
                           duration: Duration(seconds:2),
                           backgroundColor: Colors.black87,
                           behavior: SnackBarBehavior.fixed,
                         );
                         ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        },*/
                      ),
                    ],
                  ),
                ),
              ),
            ]
          ),
        ),
      ),
    );
  }
}
