
class ProductStoreModels{
   //String? productId;
   //String? productCategory;
   String? productName;
   double? productInitialPrice;
   double? productRatting;
   //List<dynamic>? productSize;
   //List<dynamic>? productColors;
   //List<dynamic>? projectImage;
   String? productDescription;

  ProductStoreModels({
    //required this.productId,
    //required this.productCategory,
    required this.productName,
    required this.productInitialPrice,
    required this.productRatting,
    //required this.productSize,
    //required this.productColors,
    required this.productDescription,
    //required this.projectImage,
  });

   ProductStoreModels.fromMap(Map<String, dynamic> map) {
   // productId= map['productId'];
    //productCategory= map['productCategory'];
    productName= map['productName'];
    productInitialPrice= map['productInitialPrice'];
    productRatting= map['productRatting'];
    //productSize= map['productSize'];
    //productColors= map['productColors'];
    productDescription= map['productDescription'];
   // projectImage= map['projectImage'];
    }


  Map<String,Object?> toMap(){
    return {
      //'productId':productId,
      //'productCategory':productCategory,
      'productName':productName,
      'productInitialPrice':productInitialPrice,
      'productRatting':productRatting,
      //'productSize':productSize,
      //'productColors':productColors,
      'productDescription':productDescription,
      //'projectImage':projectImage,
    };
  }
}