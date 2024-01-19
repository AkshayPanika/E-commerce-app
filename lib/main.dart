import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'AB_New_project/Admin_folder/Admin_home_screen/admin_home_screen.dart';
import 'firebase_options.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp( const OnShop());
}

class OnShop extends StatelessWidget {
  const OnShop({super.key});

  @override
  Widget build(BuildContext context) {
    return  const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AdminHomeScreen(),
    );
  }
}