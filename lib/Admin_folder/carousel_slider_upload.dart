import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import '../Reusable_widget/text_style_widget.dart';
import 'admin_model.dart';

class CarouselSliderUpload extends StatefulWidget {
  const CarouselSliderUpload({super.key});

  @override
  State<CarouselSliderUpload> createState() => _CarouselSliderUploadState();
}

class _CarouselSliderUploadState extends State<CarouselSliderUpload> {

  TextEditingController carouselSliderText = TextEditingController();

  /*List<File> selectedImages = [];
  final picker = ImagePicker();
  ///___ Pic image from gallery
  void picImages() async {
    final pickedFile = await picker.pickMultiImage();
    List<XFile> filePick = pickedFile;
    if (filePick.isNotEmpty) {
      for (var i = 0; i < filePick.length; i++) {
        selectedImages.add(File(filePick[i].path));
        print(File(filePick[i].path));
      }
      setState(() { });
    }
    else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Nothing is selected')));
    }

  }*/
  ///_ firebase
/*  void saveImage()async{
    String title = carouselSliderText.text.trim();
    if(title != "" && selectedImages != null ){
      selectedImages.forEach((element) async{
        UploadTask uploadTask = FirebaseStorage.instance.ref().child("carouselSlider/${element.path}").putFile(element);
        TaskSnapshot taskSnapshot = await uploadTask;
        String downloadUrl = await taskSnapshot.ref.getDownloadURL();
        var userData = CarouselSliderModel(imageUrl: downloadUrl,title:title ).toMap();
        FirebaseFirestore.instance.collection("carouselSlider").add(userData);
        Navigator.pop(context);
        carouselSliderText.clear();
      });
    }
    else{
      print("Please fill all the fields!");
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please fill all the fields!')));
    }
  }*/

  File? pickedImage;
  bool isPicked = false;

  void picImage()async{
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if(image != null){
      pickedImage = File(image.path);
      setState(() {
        isPicked =true;
      });
    }
  }
    void saveImage()async{
    String title = carouselSliderText.text.trim();
    if(title != "" && pickedImage != null ){
      UploadTask uploadTask = FirebaseStorage.instance.ref().child("carouselSlider").child(Uuid().v1()).putFile(pickedImage!);
      TaskSnapshot taskSnapshot = await uploadTask;
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();
      var userData = CarouselSliderModel(imageUrl: downloadUrl,title:title ).toMap();
      FirebaseFirestore.instance.collection("carouselSlider").add(userData);
      Navigator.pop(context);
      carouselSliderText.clear();
    }
    else{
      print("Please fill all the fields!");
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please fill all the fields!')));
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Text("Upload Carousel Slider Images",style: textStyle17,),
            const SizedBox(height: 25,),

            ///___ Image list
            /*Expanded(
              child: selectedImages.isEmpty // If no images is selected
                  ? Center(child: Text('Is Empty!',style: textStyle17,))
                  : GridView.builder(
                itemCount: selectedImages.length,
                gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,crossAxisSpacing: 5,mainAxisSpacing: 5
                ),
                itemBuilder: (BuildContext context, int index) {
                  return Image.file(selectedImages[index],fit: BoxFit.fill,);
                },
              ),
            ),*/
            Expanded(child: Container(
              child:isPicked ? Image.file(pickedImage!):Container(),
            )),

            /// Text field
            Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: TextField(
                controller: carouselSliderText,
                decoration: const InputDecoration(
                  hintText: "Title",
                ),
              ),
            ),
            20.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(onPressed: (){
                  picImage();
                }, child:  Text("Upload image",style:textStyle15,)),
                ElevatedButton(onPressed: (){
                  saveImage();
                }, child:  Text("save image",style: textStyle15,)),
              ],
            ),

           30.height,

          ],
        ),
      ),
    );
  }
}
