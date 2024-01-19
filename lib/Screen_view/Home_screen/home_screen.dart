import '../../Custom_widget/text_style_widget.dart';
import 'package:flutter/material.dart';
import 'app_bar_widget.dart';
import 'carousel_slider_widget.dart';
import 'new_arrival_product_list.dart';
import 'popular_list.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.blueGrey.shade100,
      body:  SafeArea(
        child: Column(
          children: [

            ///___ Appbar
            const AppBarWidget(),
            10.height,

            const Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ///___ Popular list
                    PopularList(),


                    ///___ Carousel slider widget
                    CarouselSliderWidget(),



                    ///___ New arrivals list
                    NewArrivalProductList(),

                  ],
                ),
              ),
            )

          ],
        ),
      ),
    );
  }
}
