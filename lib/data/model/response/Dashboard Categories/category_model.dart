// To parse this JSON data, do
//
//     final categoryModel = categoryModelFromJson(jsonString);

import 'dart:convert';

List<CategoryModel> categoryModelFromJson(String str) => List<CategoryModel>.from(json.decode(str).map((x) => CategoryModel.fromJson(x)));

String categoryModelToJson(List<CategoryModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CategoryModel {
  CategoryModel({
    this.id,
    this.parentId,
    this.level,
    this.name,
    this.orderLevel,
    this.commisionRate,
    this.banner,
    this.icon,
    this.featured,
    this.top,
    this.digital,
    this.slug,
    this.metaTitle,
    this.metaDescription,
    this.createdAt,
    this.updatedAt,
    this.position,
    this.translations,
    this.childes,
    this.priority,
    this.numberOfChildren,
    this.links,
  });

  int id;
  int parentId;
  String level;
  String name;
  String orderLevel;
  String commisionRate;
  String banner;
  String icon;
  String featured;
  String top;
  String digital;
  String slug;
  String metaTitle;
  String metaDescription;
  DateTime createdAt;
  DateTime updatedAt;
  int position;
  List<dynamic> translations;
  List<dynamic> childes;
  int priority;
  int numberOfChildren;
  Links links;

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
    id: json["id"],
    parentId: json["parent_id"],
    level: json["level"],
    name: json["name"],
    orderLevel: json["order_level"],
    commisionRate: json["commision_rate"],
    banner: json["banner"],
    icon: json["icon"],
    featured: json["featured"],
    top: json["top"],
    digital: json["digital"],
    slug: json["slug"],
    metaTitle: json["meta_title"] == null ? null : json["meta_title"],
    metaDescription: json["meta_description"] == null ? null : json["meta_description"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    position: json["position"],
    translations: List<dynamic>.from(json["translations"].map((x) => x)),
    childes: List<dynamic>.from(json["childes"].map((x) => x)),
    priority: json["priority"],
    numberOfChildren: json["number_of_children"],
    links: Links.fromJson(json["links"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "parent_id": parentId,
    "level": level,
    "name": name,
    "order_level": orderLevel,
    "commision_rate": commisionRate,
    "banner": banner,
    "icon": icon,
    "featured": featured,
    "top": top,
    "digital": digital,
    "slug": slug,
    "meta_title": metaTitle == null ? null : metaTitle,
    "meta_description": metaDescription == null ? null : metaDescription,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "position": position,
    "translations": List<dynamic>.from(translations.map((x) => x)),
    "childes": List<dynamic>.from(childes.map((x) => x)),
    "priority": priority,
    "number_of_children": numberOfChildren,
    "links": links.toJson(),
  };
}

class Links {
  Links({
    this.products,
    this.subCategories,
  });

  String products;
  String subCategories;

  factory Links.fromJson(Map<String, dynamic> json) => Links(
    products: json["products"],
    subCategories: json["sub_categories"],
  );

  Map<String, dynamic> toJson() => {
    "products": products,
    "sub_categories": subCategories,
  };
}
