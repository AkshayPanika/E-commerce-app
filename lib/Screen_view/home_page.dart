import 'package:ecommerce_app/Reusable_widget/text_style_widget.dart';
import 'package:flutter/material.dart';
import '../Content_widget/app_bar_widget.dart';
import '../Content_widget/carousel_slider_widget.dart';
import '../Content_widget/new_arrivals.dart';
import '../Content_widget/popular_list.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
                    NewArrivalsList(),

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
