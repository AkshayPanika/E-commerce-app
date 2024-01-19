import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade100,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(15.0),
              child: Text("My favorite",style: TextStyle(fontSize: 17,color:Colors.black,fontWeight: FontWeight.w500),),
            ),

            Expanded(
              child: MasonryGridView.builder(
                gridDelegate:  const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemBuilder: (context, index) {
                  return  InkWell(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal:10),
                      child: Stack(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ///___ image
                              Container(
                                height: 200,width:200,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(color: Colors.black54),
                                  color: Colors.white
                                ),
                              ),
                              Text("Product name"),
                              Text("Product name"),
                              SizedBox(height: 25,)
                            ],
                          ),
                          const Positioned(
                            right: 0,
                            child: Card(
                              shape: OutlineInputBorder(borderSide: BorderSide(color: Colors.black54)),
                              child: Padding(
                                padding: EdgeInsets.all(2.0),
                                child: Icon(Icons.favorite_border,color: Colors.black54,size: 25,),
                              ),
                            ),)
                        ],
                      ),
                    ),
                  );
                },),
            )
          ],
        ),
      ),
    );
  }
}
