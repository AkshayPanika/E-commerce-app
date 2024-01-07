///___ CarouselSliderModel
class CarouselSliderModel {
  String? imageUrl;
  String? title;
  CarouselSliderModel({
    required this.imageUrl,
    required this.title,
  });

  CarouselSliderModel.fromMap(Map<String, dynamic> map) {
    imageUrl = map["imageUrl"];
    title = map["title"];
  }

  Map<String, dynamic> toMap() {
    return {
      "imageUrl": imageUrl,
      "title": title,
    };
  }
}

///___ NewArrivalModels
class NewArrivalModels {
  String? imageUrl;
  String? title;
  double? initialPrice;
  double? price;
  int? quantity;
  double? ratting;
  NewArrivalModels({
    required this.imageUrl,
    required this.title,
    required this.initialPrice,
    this.price,
    this.quantity,
    required this.ratting,
  });

  NewArrivalModels.fromMap(Map<String, dynamic> map) {
    imageUrl = map["imageUrl"];
    title = map["title"];
    initialPrice = map["initialPrice"];
    price = map["price"];
    quantity = map["quantity"];
    ratting = map["ratting"];
  }

  Map<String, dynamic> toMap() {
    return {
      "imageUrl": imageUrl,
      "title": title,
      "initialPrice": initialPrice,
      "price": price,
      "quantity": quantity,
      "ratting": ratting,
    };
  }
}

///___ NewArrivalModels image
class NewArrivalMultiImageModels {
  String? imageUrl;
  NewArrivalMultiImageModels({
    required this.imageUrl,
  });

  NewArrivalMultiImageModels.fromMap(Map<String, dynamic> map) {
    imageUrl = map["imageUrl"];
  }

  Map<String, dynamic> toMap() {
    return {
      "imageUrl": imageUrl,
    };
  }
}
