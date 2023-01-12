// To parse this JSON data, do
//
//     final todaysDealsModel = todaysDealsModelFromJson(jsonString);

import 'dart:convert';

TodaysDealsModel todaysDealsModelFromJson(String str) => TodaysDealsModel.fromJson(json.decode(str));

String todaysDealsModelToJson(TodaysDealsModel data) => json.encode(data.toJson());

class TodaysDealsModel {
  TodaysDealsModel({
    this.data,
    this.success,
    this.status,
  });

  List<Datum> data;
  bool success;
  int status;

  factory TodaysDealsModel.fromJson(Map<String, dynamic> json) => TodaysDealsModel(
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
    this.photos,
    this.thumbnailImage,
    this.basePrice,
    this.baseDiscountedPrice,
    this.todaysDeal,
    this.featured,
    this.unit,
    this.discount,
    this.discountType,
    this.rating,
    this.sales,
    this.links,
  });

  int id;
  String name;
  List<String> photos;
  String thumbnailImage;
  double basePrice;
  double baseDiscountedPrice;
  int todaysDeal;
  int featured;
  String unit;
  int discount;
  String discountType;
  int rating;
  int sales;
  Links links;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    name: json["name"],
    photos: List<String>.from(json["photos"].map((x) => x)),
    thumbnailImage: json["thumbnail_image"],
    basePrice: json["base_price"].toDouble(),
    baseDiscountedPrice: json["base_discounted_price"].toDouble(),
    todaysDeal: json["todays_deal"],
    featured: json["featured"],
    unit: json["unit"],
    discount: json["discount"],
    discountType: json["discount_type"],
    rating: json["rating"],
    sales: json["sales"],
    links: Links.fromJson(json["links"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "photos": List<dynamic>.from(photos.map((x) => x)),
    "thumbnail_image": thumbnailImage,
    "base_price": basePrice,
    "base_discounted_price": baseDiscountedPrice,
    "todays_deal": todaysDeal,
    "featured": featured,
    "unit": unit,
    "discount": discount,
    "discount_type": discountType,
    "rating": rating,
    "sales": sales,
    "links": links.toJson(),
  };
}

class Links {
  Links({
    this.details,
    this.reviews,
    this.related,
    this.topFromSeller,
  });

  String details;
  String reviews;
  String related;
  String topFromSeller;

  factory Links.fromJson(Map<String, dynamic> json) => Links(
    details: json["details"],
    reviews: json["reviews"],
    related: json["related"],
    topFromSeller: json["top_from_seller"],
  );

  Map<String, dynamic> toJson() => {
    "details": details,
    "reviews": reviews,
    "related": related,
    "top_from_seller": topFromSeller,
  };
}
