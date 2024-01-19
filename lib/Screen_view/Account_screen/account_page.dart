import '../../Custom_widget/text_style_widget.dart';
import 'package:ecommerce_app/Screen_view/User_data_screen/user_data_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen>  {

  bool isAnimated = false;
  String? _verificationId;
  TextEditingController phoneController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  ///___ Send otp
  void sendOTP()async{
    String phone = "+91"+phoneController.text.trim();
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber:phone,
      codeSent: (verificationId, resendToken){
        _verificationId = verificationId;
        //Navigator.popUntil(context, (route) => route.isFirst);
        //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> VerifyOtpScreen(verificationId: verificationId,phoneNumber:int.parse(phone),)));
        setState(() {
          isAnimated = !isAnimated;
        });
      },
      verificationCompleted: (credential){},
      verificationFailed: (ex){
        print(ex.code.toString());
      },
      codeAutoRetrievalTimeout: (verificationId){},
      timeout: const Duration(seconds: 30),
    );
  }
  void verifyOTP()async{
    String otp = otpController.text.trim();
    PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(verificationId:_verificationId!, smsCode: otp);
    try{
      UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(phoneAuthCredential);
      if(userCredential.user != null){
        //FirebaseFirestore.instance.collection("user id").doc(userCredential.user!.uid).collection("user data").add({"phone":widget.phoneNumber});
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> UserDataPage()));//userId:userCredential.user!.uid
      }
    }
    on FirebaseAuthException catch(ex){
      print(ex.code.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade100,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Card(
                elevation: 3,
                shape:  OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
                color: Colors.grey[300],
                child:  Padding(
                  padding: const EdgeInsets.symmetric(horizontal:40.0,vertical:40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Welcome",),
                      50.height,

                      ///___ Enter your number
                      TextField(
                        controller: phoneController,
                        decoration: const InputDecoration(
                          label: Text("Enter your number"),
                          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                        ),
                      ),
                      35.height,

                      ///___ Submit button
                      Align(
                          alignment: Alignment.centerRight,
                          child:  ElevatedButton(onPressed: (){
                           /* isAnimated = !isAnimated;
                            setState(() {

                            });*/
                            sendOTP();
                          }, child:  isAnimated ? const Icon(Icons.check_circle_outline,color: Colors.white,):const Text("Submit")),
                      ),
                      5.height,

                      ///___ Verify otp
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 500),
                        //margin: MediaQuery.of(context).viewInsets.bottom.toDouble(),
                        height:isAnimated ? 150:0 ,
                        //color: Colors.grey,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [

                              ///___ Verify otp
                              TextField(
                                controller: otpController,
                                decoration: const InputDecoration(
                                  label: Text("Verify otp"),
                                  focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                                ),
                              ),

                              35.height,
                              isAnimated ? ElevatedButton(onPressed: (){
                                verifyOTP();
                              }, child: const Text("Verify")):const SizedBox()
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
