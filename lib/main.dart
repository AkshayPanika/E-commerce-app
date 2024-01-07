import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'Screen_view/main_page.dart';
import 'firebase_options.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const OnShop());
}

class OnShop extends StatelessWidget {
  const OnShop({super.key});

  @override
  Widget build(BuildContext context) {
    return  const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainPage(),
    );
  }
}