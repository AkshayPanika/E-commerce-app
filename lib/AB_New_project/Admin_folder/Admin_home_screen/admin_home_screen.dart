import 'package:flutter/material.dart';

import '../../../Custom_widget/text_style_widget.dart';
import 'add_product_screen.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,elevation: 0.0,
        title: const Text("Admin Home Screen"),
        titleTextStyle: textStyle17,
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey,
        child: const Icon(Icons.add),
        onPressed: (){
          showModalBottomSheet(
              isScrollControlled: true,
              context: context, builder: (context) =>const AddProductScreen());
        },
      ),
    );
  }
}
