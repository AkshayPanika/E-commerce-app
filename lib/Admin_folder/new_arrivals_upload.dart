import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import '../Reusable_widget/text_style_widget.dart';
import 'admin_model.dart';

class NewArrivalUpload extends StatefulWidget {
  const NewArrivalUpload({super.key});

  @override
  State<NewArrivalUpload> createState() => _NewArrivalUploadState();
}

class _NewArrivalUploadState extends State<NewArrivalUpload> {

  TextEditingController title = TextEditingController();
  TextEditingController initialPrice = TextEditingController();
  TextEditingController ratting = TextEditingController();


  File? pickedImage;
  bool isPicked = false;
  ///___ Pic multiImages
  List<File> imagesList = [];
  final picker = ImagePicker();

  void picImages()async{
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if(image != null){
      pickedImage = File(image.path);
      setState(() {
        isPicked =true;
      });
    }
  }
  ///___ Pic image from gallery
  void picMultiImages() async {
    final pickedFile = await picker.pickMultiImage();
    List<XFile> filePick = pickedFile;
    if (filePick.isNotEmpty) {
      for (var i = 0; i < filePick.length; i++) {
        imagesList.add(File(filePick[i].path));
        print(File(filePick[i].path));
      }
      setState(() { });
    }
    else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Nothing is selected')));
    }

  }

  ///_ firebase
  var imageId ="";
  void saveImage()async{
    String titleText = title.text.trim();
    double initialPriceText = double.parse(initialPrice.text.trim());
    double  rattingText= double.parse(ratting.text.trim());
    title.clear(); initialPrice.clear(); ratting.clear();
    if(title != "" && initialPrice != "" && ratting != "" && pickedImage != null ) {
      UploadTask uploadTask = FirebaseStorage.instance.ref().child("newArrivals").child(Uuid().v1()).putFile(pickedImage!);
      TaskSnapshot taskSnapshot = await uploadTask;
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();
      var userData = NewArrivalModels(imageUrl: downloadUrl, title: titleText, initialPrice: initialPriceText,ratting: rattingText).toMap();
         FirebaseFirestore.instance.collection("newArrivals").add(userData).then((value){
           imageId = value.id;

           if(imagesList != null ){
             imagesList.forEach((element) async{
               UploadTask uploadTask = FirebaseStorage.instance.ref().child("newArrivals").child("imageCollection/${element.path}").putFile(element);
               TaskSnapshot taskSnapshot = await uploadTask;
               String downloadUrl = await taskSnapshot.ref.getDownloadURL();
               var  userData = NewArrivalMultiImageModels(imageUrl: downloadUrl).toMap();
               FirebaseFirestore.instance.collection("newArrivals").doc(imageId).collection("imageCollection").add(userData);
             });
           }
           else{ ScaffoldMessenger.of(context).showSnackBar(
               const SnackBar(content: Text('Select image')));
           }
         });
    }
    else{  ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please fill all the fields!')));
    }
  }

 /* ///_ firebase
  void saveMultiImage()async{
    if(imagesList != null ){
      imagesList.forEach((element) async{
        UploadTask uploadTask = FirebaseStorage.instance.ref().child("newArrivals").child("imageCollection/${element.path}").putFile(element);
        TaskSnapshot taskSnapshot = await uploadTask;
        String downloadUrl = await taskSnapshot.ref.getDownloadURL();
        var  userData = NewArrivalMultiImageModels(imageUrl: downloadUrl).toMap();
        FirebaseFirestore.instance.collection("newArrivals").doc(imageId).collection("imageCollection").add(userData);
      });
    }
    else{ ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Select image')));
    }
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Upload New Arrival Images",style: textStyle17,),
            const SizedBox(height: 25,),

            ///___ Image list
            Expanded(child: Container(
              child:isPicked ? Image.file(pickedImage!): const Card(
                  color: Colors.grey,
                  child: Center(child: Text("Thumbnail image is empty"),)),
            )),

            Expanded(
              child: imagesList.isEmpty // If no images is selected
                  ? const Card(
                  color: Colors.grey,
                  child: Center(child: Text("Image collection is empty"),))
                  : GridView.builder(
                itemCount: imagesList.length,
                gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,crossAxisSpacing: 5,mainAxisSpacing: 5
                ),
                itemBuilder: (BuildContext context, int index) {
                  return Image.file(imagesList[index],fit: BoxFit.fill,);
                },
              ),
            ),

            30.height,
            /// Text field
            TextFieldWidget(
              controller: title,
              title: "Title",
            ),
            TextFieldWidget(
              controller: initialPrice,
              title: "Price",
            ),
            TextFieldWidget(
              controller: ratting,
              title: "Ratting",
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(onPressed: (){
                  picImages();
                }, child:  Text("Upload thumbnail",style:textStyle15,)),
                ElevatedButton(onPressed: (){
                 picMultiImages();
                }, child:  Text("Upload image list",style:textStyle15,)),
              ],
            ),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(onPressed: (){
               saveImage();
                Navigator.pop(context);
              }, child:  Text("save image",style: textStyle15,)),
            ),

            const SizedBox(
              height: 20,
            ),

          ],
        ),
      ),
    );
  }
}
class TextFieldWidget extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  const TextFieldWidget({super.key, required this.controller, required this.title});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const OutlineInputBorder(borderSide: BorderSide(color: Colors.black54)),
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: TextField(
          controller: controller,
          decoration:  InputDecoration(
            hintText:title,
          ),
        ),
      ),);

  }
}
