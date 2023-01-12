// To parse this JSON data, do
//
//     final productDetailsModel = productDetailsModelFromJson(jsonString);

import 'dart:convert';

ProductDetailsModel productDetailsModelFromJson(String str) => ProductDetailsModel.fromJson(json.decode(str));

String productDetailsModelToJson(ProductDetailsModel data) => json.encode(data.toJson());

class ProductDetailsModel {
  ProductDetailsModel({
    this.data,
    this.success,
    this.status,
  });

  List<Datum> data;
  bool success;
  int status;

  factory ProductDetailsModel.fromJson(Map<String, dynamic> json) => ProductDetailsModel(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    success: json["success"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "success": success,
    "status": status,
  };
}

class Datum {
  Datum({
    this.id,
    this.name,
    this.addedBy,
    this.sellerId,
    this.shopId,
    this.shopName,
    this.shopLogo,
    this.photos,
    this.thumbnailImage,
    this.tags,
    this.priceHighLow,
    this.choiceOptions,
    this.colors,
    this.hasDiscount,
    this.strokedPrice,
    this.mainPrice,
    this.calculablePrice,
    this.unitPrice,
    this.tax,
    this.currencySymbol,
    this.currentStock,
    this.unit,
    this.rating,
    this.ratingCount,
    this.earnPoint,
    this.description,
  });

  int id;
  String name;
  String addedBy;
  int sellerId;
  int shopId;
  String shopName;
  String shopLogo;
  List<dynamic> photos;
  String thumbnailImage;
  List<String> tags;
  String priceHighLow;
  List<dynamic> choiceOptions;
  List<dynamic> colors;
  bool hasDiscount;
  String strokedPrice;
  String mainPrice;
  int calculablePrice;
  String unitPrice;
  int tax;
  String currencySymbol;
  int currentStock;
  String unit;
  int rating;
  int ratingCount;
  int earnPoint;
  dynamic description;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    name: json["name"],
    addedBy: json["added_by"],
    sellerId: json["seller_id"],
    shopId: json["shop_id"],
    shopName: json["shop_name"],
    shopLogo: json["shop_logo"],
    photos: List<dynamic>.from(json["photos"].map((x) => x)),
    thumbnailImage: json["thumbnail_image"],
    tags: List<String>.from(json["tags"].map((x) => x)),
    priceHighLow: json["price_high_low"],
    choiceOptions: List<dynamic>.from(json["choice_options"].map((x) => x)),
    colors: List<dynamic>.from(json["colors"].map((x) => x)),
    hasDiscount: json["has_discount"],
    strokedPrice: json["stroked_price"],
    mainPrice: json["main_price"],
    calculablePrice: json["calculable_price"],
    unitPrice: json["unit_price"],
    tax: json["tax"],
    currencySymbol: json["currency_symbol"],
    currentStock: json["current_stock"],
    unit: json["unit"],
    rating: json["rating"],
    ratingCount: json["rating_count"],
    earnPoint: json["earn_point"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "added_by": addedBy,
    "seller_id": sellerId,
    "shop_id": shopId,
    "shop_name": shopName,
    "shop_logo": shopLogo,
    "photos": List<dynamic>.from(photos.map((x) => x)),
    "thumbnail_image": thumbnailImage,
    "tags": List<dynamic>.from(tags.map((x) => x)),
    "price_high_low": priceHighLow,
    "choice_options": List<dynamic>.from(choiceOptions.map((x) => x)),
    "colors": List<dynamic>.from(colors.map((x) => x)),
    "has_discount": hasDiscount,
    "stroked_price": strokedPrice,
    "main_price": mainPrice,
    "calculable_price": calculablePrice,
    "unit_price": unitPrice,
    "tax": tax,
    "currency_symbol": currencySymbol,
    "current_stock": currentStock,
    "unit": unit,
    "rating": rating,
    "rating_count": ratingCount,
    "earn_point": earnPoint,
    "description": description,
  };
}
