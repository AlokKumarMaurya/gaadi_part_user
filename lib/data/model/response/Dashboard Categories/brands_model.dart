// To parse this JSON data, do
//
//     final brandsModel = brandsModelFromJson(jsonString);

import 'dart:convert';

BrandsModel brandsModelFromJson(String str) => BrandsModel.fromJson(json.decode(str));

String brandsModelToJson(BrandsModel data) => json.encode(data.toJson());

class BrandsModel {
  BrandsModel({
    this.data,
    this.links,
    this.meta,
    this.success,
    this.status,
  });

  List<Datum> data;
  BrandsModelLinks links;
  Meta meta;
  bool success;
  int status;

  factory BrandsModel.fromJson(Map<String, dynamic> json) => BrandsModel(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    links: BrandsModelLinks.fromJson(json["links"]),
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
    this.logo,
    this.links,
  });

  int id;
  String name;
  String logo;
  DatumLinks links;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    name: json["name"],
    logo: json["logo"],
    links: DatumLinks.fromJson(json["links"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "logo": logo,
    "links": links.toJson(),
  };
}

class DatumLinks {
  DatumLinks({
    this.products,
  });

  String products;

  factory DatumLinks.fromJson(Map<String, dynamic> json) => DatumLinks(
    products: json["products"],
  );

  Map<String, dynamic> toJson() => {
    "products": products,
  };
}

class BrandsModelLinks {
  BrandsModelLinks({
    this.first,
    this.last,
    this.prev,
    this.next,
  });

  String first;
  String last;
  dynamic prev;
  dynamic next;

  factory BrandsModelLinks.fromJson(Map<String, dynamic> json) => BrandsModelLinks(
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
