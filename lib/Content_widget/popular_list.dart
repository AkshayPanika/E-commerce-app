import 'package:flutter/material.dart';
import '../Reusable_widget/text_style_widget.dart';

class PopularList extends StatefulWidget {
  const PopularList({super.key});

  @override
  State<PopularList> createState() => _PopularListState();
}

class _PopularListState extends State<PopularList> {

 List<Map<String,dynamic>> popularList =[
   {
     "imageUrl":'https://rukminim2.flixcart.com/image/850/1000/xif0q/dress/g/y/k/s-kk-108-shine-fashion-original-imaghrrnfw2ebfgj.jpeg?q=90',
     "title":'Shoot 1',
   },
   {
     "imageUrl":'https://i.pinimg.com/736x/ea/ab/a4/eaaba4eb3246aab7cab0fc3683dd7cfb.jpg',
     "title":'Shoot 2',
   },
   {
     "imageUrl":'https://shotkit.com/wp-content/uploads/2022/05/what-to-wear-photoshoot-joshua-abner.jpeg',
     "title":'Shoot 3',
   },
   {
     "imageUrl":'https://i.pinimg.com/474x/25/a1/d7/25a1d77b76b23c2c5625c1142656f7ce.jpg',
     "title":'Shoot 4',
   },
   {
     "imageUrl":'https://i.pinimg.com/474x/21/cd/e8/21cde8a50212e616026934e4f9d09758.jpg',
     "title":'Shari 1',
   },
   {
     "imageUrl":'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRldzF1dpm3UJ9dWhk99VGKxLbLcr3TyawKxkSsLlr-pJMPjAAjlSVBn473QfC-kHxYmK0&usqp=CAU',
     "title":'Shari 2',
   },
   {
     "imageUrl":'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSPCLvZbjWcXYMmxEF_v_QrGLiejNGLKdDRgA&usqp=CAU',
     "title":'blouse'
   }
 ];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          ///___ Head line text
          Text("Explore popular categories",style: textStyle17,),
          10.height,

          ///___ Popular list
          SizedBox(
            height: 90,
            child: ListView.builder(
              itemCount: popularList.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Column(
                    children: [

                      ///___ Card
                       Card(
                        shape: const OutlineInputBorder(borderSide: BorderSide(color: Colors.black54)),
                        child:SizedBox(height: 50,width: 50,
                        child: Image.network(popularList[index]['imageUrl'].toString(),fit: BoxFit.fill,),
                        ),
                      ),
                      ///___ Text
                      Text(popularList[index]['title'],style: textStyle15,),
                    ],
                  ),
                );
              },),
          )
        ],
      ),
    );
  }
}
