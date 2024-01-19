import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/AB_New_project/Admin_folder/product_store_model.dart';
import 'package:ecommerce_app/Custom_widget/text_style_widget.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../Costom_widget/round_button_widget.dart';
import '../Costom_widget/text_form_field_widget.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {

  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController= TextEditingController();
  TextEditingController priceController= TextEditingController();
  TextEditingController rattingController= TextEditingController();
  TextEditingController descriptionController= TextEditingController();

  File? pickedImage;
  bool isPicked = false;
  ///___  multiImages store
  List<File> imagesList = [];
  final picker = ImagePicker();

  ///___ Pic pic multi images from gallery
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
  void saveData()async {
    String name = nameController.text.trim();
    String description = descriptionController.text.trim();
    double price = double.parse(priceController.text.trim());
    double ratting = double.parse(rattingController.text.trim());
    //name.clear(); description.clear(); price.clear(), ratting.clear();
    if (name != "" && description != "" && price != "" && ratting != "" && pickedImage != null)
      {
      imagesList.forEach((element) async {
        UploadTask uploadTask = FirebaseStorage.instance.ref().child("ProductStore/${element.path}").putFile(element);
        TaskSnapshot taskSnapshot = await uploadTask;
        String downloadUrl = await taskSnapshot.ref.getDownloadURL();
        var userData = ProductStoreModels(productName: name,productDescription: description,
          productInitialPrice: price,productRatting: ratting,);
        FirebaseFirestore.instance.collection("ProductStore").add(userData.toMap());
      });
    }
    else{ ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Select image')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            80.height,
             Text("Upload Product",style: textStyle17,),
            50.height,
            Form(
                key:_formKey,
                child: Column(
              children: [
                15.height,
                ///___ Product name
                TextFormFieldWidget(
                  controller: nameController,
                  hintText: "Product name",
                ),

                15.height,
                ///___ Product initialPrice
                TextFormFieldWidget(
                  controller: priceController,
                  hintText: "Product initial price",
                ),

                15.height,
                ///___ Product ratting
                TextFormFieldWidget(
                  controller: rattingController,
                  hintText: "Product ratting",
                ),


                15.height,
                ///___ Product description
                TextFormFieldWidget(
                  controller: descriptionController,
                  hintText: "Product description",
                ),

                15.height,
                SizedBox(
                  height: 200,width: 500,
                  child: imagesList.isEmpty // If no images is selected
                      ? Card(elevation: 1,
                      color: Colors.white,
                      child: Center(child: Text("Image collection is empty",style: textStyle17,),))
                      : GridView.builder(
                    itemCount: imagesList.length,
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: Card(
                            shape: const OutlineInputBorder(borderSide: BorderSide(color: Colors.black54)),
                            child: Image.file(imagesList[index])),
                      );
                    },
                  ),
                ),

                50.height,
                 Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RoundButtonWidget(text: "Upload image",
                    onTap: () {
                      picMultiImages();
                    },),
                    RoundButtonWidget(text: "Submit",
                    onTap: () {
                      saveData();
                    },),
                  ],
                )
              ],
            ))
          ],
        ),
      ),
    );
  }
}
