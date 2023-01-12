// To parse this JSON data, do
//
//     final getCartModel = getCartModelFromJson(jsonString);

import 'dart:convert';

GetCartModel getCartModelFromJson(String str) => GetCartModel.fromJson(json.decode(str));

String getCartModelToJson(GetCartModel data) => json.encode(data.toJson());

class GetCartModel {
  GetCartModel({
    this.status,
    this.totalPrice,
    this.data,
  });

  int status;
  int totalPrice;
  List<Datum> data;

  factory GetCartModel.fromJson(Map<String, dynamic> json) => GetCartModel(
    status: json["status"],
    totalPrice: json["total_price"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "total_price": totalPrice,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.id,
    this.customerId,
    this.cartGroupId,
    this.productId,
    this.color,
    this.choices,
    this.variations,
    this.variant,
    this.quantity,
    this.price,
    this.tax,
    this.discount,
    this.slug,
    this.name,
    this.thumbnail,
    this.sellerId,
    this.sellerIs,
    this.createdAt,
    this.updatedAt,
    this.shopInfo,
    this.shippingCost,
    this.shippingType,
    this.minimumOrderQty,
    this.product,
  });

  int id;
  String customerId;
  dynamic cartGroupId;
  String productId;
  dynamic color;
  Choices choices;
  Variations variations;
  dynamic variant;
  String quantity;
  String price;
  String tax;
  String discount;
  String slug;
  String name;
  String thumbnail;
  String sellerId;
  String sellerIs;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic shopInfo;
  String shippingCost;
  String shippingType;
  int minimumOrderQty;
  Product product;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    customerId: json["customer_id"],
    cartGroupId: json["cart_group_id"],
    productId: json["product_id"],
    color: json["color"],
    choices: Choices.fromJson(json["choices"]),
    variations: Variations.fromJson(json["variations"]),
    variant: json["variant"],
    quantity: json["quantity"],
    price: json["price"],
    tax: json["tax"],
    discount: json["discount"],
    slug: json["slug"],
    name: json["name"],
    thumbnail: json["thumbnail"],
    sellerId: json["seller_id"],
    sellerIs: json["seller_is"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    shopInfo: json["shop_info"],
    shippingCost: json["shipping_cost"],
    shippingType: json["shipping_type"],
    minimumOrderQty: json["minimum_order_qty"],
    product: Product.fromJson(json["product"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "customer_id": customerId,
    "cart_group_id": cartGroupId,
    "product_id": productId,
    "color": color,
    "choices": choices.toJson(),
    "variations": variations.toJson(),
    "variant": variant,
    "quantity": quantity,
    "price": price,
    "tax": tax,
    "discount": discount,
    "slug": slug,
    "name": name,
    "thumbnail": thumbnail,
    "seller_id": sellerId,
    "seller_is": sellerIs,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "shop_info": shopInfo,
    "shipping_cost": shippingCost,
    "shipping_type": shippingType,
    "minimum_order_qty": minimumOrderQty,
    "product": product.toJson(),
  };
}

class Choices {
  Choices({
    this.choice6,
  });

  String choice6;

  factory Choices.fromJson(Map<String, dynamic> json) => Choices(
    choice6: json["choice_6"],
  );

  Map<String, dynamic> toJson() => {
    "choice_6": choice6,
  };
}

class Product {
  Product({
    this.id,
    this.currentStock,
    this.minimumOrderQty,
    this.reviewsCount,
    this.totalCurrentStock,
    this.translations,
    this.reviews,
  });

  int id;
  String currentStock;
  int minimumOrderQty;
  int reviewsCount;
  int totalCurrentStock;
  List<dynamic> translations;
  List<dynamic> reviews;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    currentStock: json["current_stock"],
    minimumOrderQty: json["minimum_order_qty"],
    reviewsCount: json["reviews_count"],
    totalCurrentStock: json["total_current_stock"],
    translations: List<dynamic>.from(json["translations"].map((x) => x)),
    reviews: List<dynamic>.from(json["reviews"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "current_stock": currentStock,
    "minimum_order_qty": minimumOrderQty,
    "reviews_count": reviewsCount,
    "total_current_stock": totalCurrentStock,
    "translations": List<dynamic>.from(translations.map((x) => x)),
    "reviews": List<dynamic>.from(reviews.map((x) => x)),
  };
}

class Variations {
  Variations({
    this.color,
    this.occassion,
  });

  String color;
  String occassion;

  factory Variations.fromJson(Map<String, dynamic> json) => Variations(
    color: json["color"],
    occassion: json["Occassion"],
  );

  Map<String, dynamic> toJson() => {
    "color": color,
    "Occassion": occassion,
  };
}
