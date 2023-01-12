// To parse this JSON data, do
//
//     final brandsAndProductsModel = brandsAndProductsModelFromJson(jsonString);

import 'dart:convert';

BrandsAndProductsModel brandsAndProductsModelFromJson(String str) => BrandsAndProductsModel.fromJson(json.decode(str));

String brandsAndProductsModelToJson(BrandsAndProductsModel data) => json.encode(data.toJson());

class BrandsAndProductsModel {
  BrandsAndProductsModel({
    this.data,
    this.links,
    this.meta,
    this.success,
    this.status,
  });

  List<Datum> data;
  BrandsAndProductsModelLinks links;
  Meta meta;
  bool success;
  int status;

  factory BrandsAndProductsModel.fromJson(Map<String, dynamic> json) => BrandsAndProductsModel(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    links: BrandsAndProductsModelLinks.fromJson(json["links"]),
    meta: Meta.fromJson(json["meta"]),
    success: json["success"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "links": links.toJson(),
    "meta": meta.toJson(),
    "success": success,
    "status": status,
  };
}

class Datum {
  Datum({
    this.id,
    this.name,
    this.thumbnailImage,
    this.basePrice,
    this.rating,
    this.sales,
    this.links,
  });

  int id;
  String name;
  String thumbnailImage;
  String basePrice;
  int rating;
  int sales;
  DatumLinks links;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    name: json["name"],
    thumbnailImage: json["thumbnail_image"],
    basePrice: json["base_price"],
    rating: json["rating"],
    sales: json["sales"],
    links: DatumLinks.fromJson(json["links"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "thumbnail_image": thumbnailImage,
    "base_price": basePrice,
    "rating": rating,
    "sales": sales,
    "links": links.toJson(),
  };
}

class DatumLinks {
  DatumLinks({
    this.details,
  });

  String details;

  factory DatumLinks.fromJson(Map<String, dynamic> json) => DatumLinks(
    details: json["details"],
  );

  Map<String, dynamic> toJson() => {
    "details": details,
  };
}

class BrandsAndProductsModelLinks {
  BrandsAndProductsModelLinks({
    this.first,
    this.last,
    this.prev,
    this.next,
  });

  String first;
  String last;
  dynamic prev;
  dynamic next;

  factory BrandsAndProductsModelLinks.fromJson(Map<String, dynamic> json) => BrandsAndProductsModelLinks(
    first: json["first"],
    last: json["last"],
    prev: json["prev"],
    next: json["next"],
  );

  Map<String, dynamic> toJson() => {
    "first": first,
    "last": last,
    "prev": prev,
    "next": next,
  };
}

class Meta {
  Meta({
    this.currentPage,
    this.from,
    this.lastPage,
    this.path,
    this.perPage,
    this.to,
    this.total,
  });

  int currentPage;
  int from;
  int lastPage;
  String path;
  int perPage;
  int to;
  int total;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    currentPage: json["current_page"],
    from: json["from"],
    lastPage: json["last_page"],
    path: json["path"],
    perPage: json["per_page"],
    to: json["to"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "from": from,
    "last_page": lastPage,
    "path": path,
    "per_page": perPage,
    "to": to,
    "total": total,
  };
}
