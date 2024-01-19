import 'package:ecommerce_app/Custom_widget/cart_widget.dart';
import 'package:flutter/material.dart';
import '../../Custom_widget/reusableTextWidget.dart';
import '../../Custom_widget/text_style_widget.dart';

class ShoppingPage extends StatefulWidget {
  const ShoppingPage({super.key});

  @override
  State<ShoppingPage> createState() => _ShoppingPageState();
}

class _ShoppingPageState extends State<ShoppingPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade100,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///___ Appbar
              const Padding(
                padding: EdgeInsets.all(15.0),
                child: Text("Shopping now",style: TextStyle(fontSize: 17,color:Colors.black,fontWeight: FontWeight.w500),),
              ),

              ///___ Cart list
              Expanded(child:
              ListView.builder(
               itemCount: 3,
                itemBuilder: (context, index) {
                return   Padding(
                  padding: const EdgeInsets.symmetric(vertical:5.0),
                  child: Stack(
                    children: [
                      CardWidgetWithPadding(
                        padding: 10,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [

                                ///___ Image
                                 const CardWidget(
                                   child: SizedBox(height: 100,width: 100,),
                                 ),

                                ///___ Text
                                10.width,
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "name",
                                      style: textStyle15,),
                                    5.height,
                                   Text(
                                       "Price",
                                       //"${prices[index]}",
                                       style: textStyle15),
                                    5.height,

                                  ],
                                ),
                              ],
                            ),
                          ],
                        )
                      ),
                      const Positioned(
                          right: 10,top: 10,
                          child: Icon(Icons.delete,size: 30,)),
                      Positioned(
                          right: 5,bottom: 5,
                          child:   CardWidget(
                        child: Padding(
                          padding:const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                          child: Row(
                            children: [
                              InkWell(
                                  onTap: () {},
                                  child: const Icon(Icons.remove,size: 30,)),
                              10.width,
                               const Text("1",style: TextStyle(fontSize: 19),),
                              10.width,
                              const InkWell(
                                  child:  Icon(Icons.add,size: 30,)),

                            ],
                          ),
                        ),
                      )),
                    ],
                  ),
                );
              },),
              ),

               Padding(
                 padding: const EdgeInsets.symmetric(horizontal: 10.0),
                 child: Column(
                  children: [

                    ///__ Discount code text
                     Padding(
                      padding:const EdgeInsets.symmetric(horizontal:40,vertical: 20),
                      child: Card(
                        elevation: 2,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal:8, vertical: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text("Enter discount code",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500, color: Colors.black54)),
                              10.width,
                              const Text("Apply",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500, color: Colors.green)),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const ReusableRowText(
                      text1: "Subtotal",
                      text2: "___",
                    ),
                    const Divider(color: Colors.black,height: 1),
                    10.height,
                    const ReusableRowText(
                      text1: "Total",
                      text2: "___",
                    ),
                    const Divider(color: Colors.black,height: 1),
                    40.height,


                     CardWidget(
                      child: ListTile(
                        title: Text("Price",style: textStyle15),
                        trailing: CardWidget(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                              child: Text("Go to pay",style: textStyle15),
                            ))
                      ),
                    ),

                    20.height
                  ],
              ),
               )
            ],
          ),
        ),
      ),
    );
  }

}

