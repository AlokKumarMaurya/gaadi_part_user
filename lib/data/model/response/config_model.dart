// To parse this JSON data, do
//
//     final configModel = configModelFromJson(jsonString);

import 'dart:convert';

ConfigModel configModelFromJson(String str) => ConfigModel.fromJson(json.decode(str));

String configModelToJson(ConfigModel data) => json.encode(data.toJson());

class ConfigModel {
  ConfigModel({
    this.baseUrls,
    this.staticUrls,
    this.aboutUs,
    this.privacyPolicy,
    this.faq,
    this.termsConditions,
    this.currencyList,
    this.currencySymbolPosition,
    this.digitalPayment,
    this.cashOnDelivery,
    this.systemDefaultCurrancy,
    this.businessMode,
    this.maintenanceMode,
    this.language,
    this.colors,
    this.unit,
    this.shippingMethod,
    this.countryCode,
    this.socialLogin,
    this.currencyModel,
    this.forgotPasswordVerification,
    this.announcement,
    this.pixelAnalytics,
    this.softwareVersion,
    this.decimalPointSettings,
    this.inhouseSelectedShippingType,
    this.billingInputByCustomer,
    this.minimumOrderLimit,
    this.walletStatus,
    this.loyaltyPointStatus,
    this.loyaltyPointExchangeRate,
    this.loyaltyPointMinimumPoint,
    this.emailVerification,
    this.phoneVerification,
  });

  BaseUrls baseUrls;
  StaticUrls staticUrls;
  String aboutUs;
  String privacyPolicy;
  List<Faq> faq;
  String termsConditions;
  List<CurrencyList> currencyList;
  String currencySymbolPosition;
  bool digitalPayment;
  bool cashOnDelivery;
  int systemDefaultCurrancy;
  String businessMode;
  bool maintenanceMode;
  List<Language> language;
  List<Color> colors;
  List<String> unit;
  String shippingMethod;
  String countryCode;
  List<SocialLogin> socialLogin;
  String currencyModel;
  String forgotPasswordVerification;
  Announcement announcement;
  String pixelAnalytics;
  dynamic softwareVersion;
  int decimalPointSettings;
  String inhouseSelectedShippingType;
  int billingInputByCustomer;
  int minimumOrderLimit;
  int walletStatus;
  int loyaltyPointStatus;
  int loyaltyPointExchangeRate;
  int loyaltyPointMinimumPoint;
  bool emailVerification;
  bool phoneVerification;

  factory ConfigModel.fromJson(Map<String, dynamic> json) => ConfigModel(
    baseUrls: BaseUrls.fromJson(json["base_urls"]),
    staticUrls: StaticUrls.fromJson(json["static_urls"]),
    aboutUs: json["about_us"],
    privacyPolicy: json["privacy_policy"],
    faq: List<Faq>.from(json["faq"].map((x) => Faq.fromJson(x))),
    termsConditions: json["terms_&_conditions"],
    currencyList: List<CurrencyList>.from(json["currency_list"].map((x) => CurrencyList.fromJson(x))),
    currencySymbolPosition: json["currency_symbol_position"],
    digitalPayment: json["digital_payment"],
    cashOnDelivery: json["cash_on_delivery"],
    systemDefaultCurrancy: json["system default currancy"],
    businessMode: json["business_mode"],
    maintenanceMode: json["maintenance_mode"],
    language: List<Language>.from(json["language"].map((x) => Language.fromJson(x))),
    colors: List<Color>.from(json["colors"].map((x) => Color.fromJson(x))),
    unit: List<String>.from(json["unit"].map((x) => x)),
    shippingMethod: json["shipping_method"],
    countryCode: json["country_code"],
    socialLogin: List<SocialLogin>.from(json["social_login"].map((x) => SocialLogin.fromJson(x))),
    currencyModel: json["currency_model"],
    forgotPasswordVerification: json["forgot_password_verification"],
    announcement: Announcement.fromJson(json["announcement"]),
    pixelAnalytics: json["pixel_analytics"],
    softwareVersion: json["software_version"],
    decimalPointSettings: json["decimal_point_settings"],
    inhouseSelectedShippingType: json["inhouse_selected_shipping_type"],
    billingInputByCustomer: json["billing_input_by_customer"],
    minimumOrderLimit: json["minimum_order_limit"],
    walletStatus: json["wallet_status"],
    loyaltyPointStatus: json["loyalty_point_status"],
    loyaltyPointExchangeRate: json["loyalty_point_exchange_rate"],
    loyaltyPointMinimumPoint: json["loyalty_point_minimum_point"],
    emailVerification: json["email_verification"],
    phoneVerification: json["phone_verification"],
  );

  Map<String, dynamic> toJson() => {
    "base_urls": baseUrls.toJson(),
    "static_urls": staticUrls.toJson(),
    "about_us": aboutUs,
    "privacy_policy": privacyPolicy,
    "faq": List<dynamic>.from(faq.map((x) => x.toJson())),
    "terms_&_conditions": termsConditions,
    "currency_list": List<dynamic>.from(currencyList.map((x) => x.toJson())),
    "currency_symbol_position": currencySymbolPosition,
    "digital_payment": digitalPayment,
    "cash_on_delivery": cashOnDelivery,
    "system default currancy": systemDefaultCurrancy,
    "business_mode": businessMode,
    "maintenance_mode": maintenanceMode,
    "language": List<dynamic>.from(language.map((x) => x.toJson())),
    "colors": List<dynamic>.from(colors.map((x) => x.toJson())),
    "unit": List<dynamic>.from(unit.map((x) => x)),
    "shipping_method": shippingMethod,
    "country_code": countryCode,
    "social_login": List<dynamic>.from(socialLogin.map((x) => x.toJson())),
    "currency_model": currencyModel,
    "forgot_password_verification": forgotPasswordVerification,
    "announcement": announcement.toJson(),
    "pixel_analytics": pixelAnalytics,
    "software_version": softwareVersion,
    "decimal_point_settings": decimalPointSettings,
    "inhouse_selected_shipping_type": inhouseSelectedShippingType,
    "billing_input_by_customer": billingInputByCustomer,
    "minimum_order_limit": minimumOrderLimit,
    "wallet_status": walletStatus,
    "loyalty_point_status": loyaltyPointStatus,
    "loyalty_point_exchange_rate": loyaltyPointExchangeRate,
    "loyalty_point_minimum_point": loyaltyPointMinimumPoint,
    "email_verification": emailVerification,
    "phone_verification": phoneVerification,
  };
}

class Announcement {
  Announcement({
    this.status,
    this.color,
    this.textColor,
    this.announcement,
  });

  String status;
  String color;
  String textColor;
  String announcement;

  factory Announcement.fromJson(Map<String, dynamic> json) => Announcement(
    status: json["status"],
    color: json["color"],
    textColor: json["text_color"],
    announcement: json["announcement"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "color": color,
    "text_color": textColor,
    "announcement": announcement,
  };
}

class BaseUrls {
  BaseUrls({
    this.productImageUrl,
    this.productThumbnailUrl,
    this.brandImageUrl,
    this.customerImageUrl,
    this.bannerImageUrl,
    this.categoryImageUrl,
    this.reviewImageUrl,
    this.sellerImageUrl,
    this.shopImageUrl,
    this.notificationImageUrl,
  });

  String productImageUrl;
  String productThumbnailUrl;
  String brandImageUrl;
  String customerImageUrl;
  String bannerImageUrl;
  String categoryImageUrl;
  String reviewImageUrl;
  String sellerImageUrl;
  String shopImageUrl;
  String notificationImageUrl;

  factory BaseUrls.fromJson(Map<String, dynamic> json) => BaseUrls(
    productImageUrl: json["product_image_url"],
    productThumbnailUrl: json["product_thumbnail_url"],
    brandImageUrl: json["brand_image_url"],
    customerImageUrl: json["customer_image_url"],
    bannerImageUrl: json["banner_image_url"],
    categoryImageUrl: json["category_image_url"],
    reviewImageUrl: json["review_image_url"],
    sellerImageUrl: json["seller_image_url"],
    shopImageUrl: json["shop_image_url"],
    notificationImageUrl: json["notification_image_url"],
  );

  Map<String, dynamic> toJson() => {
    "product_image_url": productImageUrl,
    "product_thumbnail_url": productThumbnailUrl,
    "brand_image_url": brandImageUrl,
    "customer_image_url": customerImageUrl,
    "banner_image_url": bannerImageUrl,
    "category_image_url": categoryImageUrl,
    "review_image_url": reviewImageUrl,
    "seller_image_url": sellerImageUrl,
    "shop_image_url": shopImageUrl,
    "notification_image_url": notificationImageUrl,
  };
}

class Color {
  Color({
    this.id,
    this.name,
    this.code,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String name;
  String code;
  DateTime createdAt;
  DateTime updatedAt;

  factory Color.fromJson(Map<String, dynamic> json) => Color(
    id: json["id"],
    name: json["name"],
    code: json["code"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "code": code,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

class CurrencyList {
  CurrencyList({
    this.id,
    this.name,
    this.symbol,
    this.exchangeRate,
    this.status,
    this.code,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String name;
  String symbol;
  int exchangeRate;
  int status;
  String code;
  DateTime createdAt;
  DateTime updatedAt;

  factory CurrencyList.fromJson(Map<String, dynamic> json) => CurrencyList(
    id: json["id"],
    name: json["name"],
    symbol: json["symbol"],
    exchangeRate: json["exchange_rate"],
    status: json["status"],
    code: json["code"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "symbol": symbol,
    "exchange_rate": exchangeRate,
    "status": status,
    "code": code,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

class Faq {
  Faq({
    this.id,
    this.type,
    this.title,
    this.slug,
    this.content,
    this.metaTitle,
    this.metaDescription,
    this.keywords,
    this.metaImage,
    this.createdAt,
    this.updatedAt,
  });

  String id;
  String type;
  String title;
  String slug;
  String content;
  String metaTitle;
  String metaDescription;
  String keywords;
  String metaImage;
  DateTime createdAt;
  DateTime updatedAt;

  factory Faq.fromJson(Map<String, dynamic> json) => Faq(
    id: json["id"],
    type: json["type"],
    title: json["title"],
    slug: json["slug"],
    content: json["content"] == null ? null : json["content"],
    metaTitle: json["meta_title"] == null ? null : json["meta_title"],
    metaDescription: json["meta_description"] == null ? null : json["meta_description"],
    keywords: json["keywords"] == null ? null : json["keywords"],
    metaImage: json["meta_image"] == null ? null : json["meta_image"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "title": title,
    "slug": slug,
    "content": content == null ? null : content,
    "meta_title": metaTitle == null ? null : metaTitle,
    "meta_description": metaDescription == null ? null : metaDescription,
    "keywords": keywords == null ? null : keywords,
    "meta_image": metaImage == null ? null : metaImage,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

class Language {
  Language({
    this.name,
    this.code,
  });

  String name;
  String code;

  factory Language.fromJson(Map<String, dynamic> json) => Language(
    name: json["name"],
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "code": code,
  };
}

class SocialLogin {
  SocialLogin({
    this.loginMedium,
    this.status,
  });

  String loginMedium;
  bool status;

  factory SocialLogin.fromJson(Map<String, dynamic> json) => SocialLogin(
    loginMedium: json["login_medium"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "login_medium": loginMedium,
    "status": status,
  };
}

class StaticUrls {
  StaticUrls({
    this.contactUs,
    this.brands,
    this.categories,
    this.customerAccount,
  });

  String contactUs;
  String brands;
  String categories;
  String customerAccount;

  factory StaticUrls.fromJson(Map<String, dynamic> json) => StaticUrls(
    contactUs: json["contact_us"],
    brands: json["brands"],
    categories: json["categories"],
    customerAccount: json["customer_account"],
  );

  Map<String, dynamic> toJson() => {
    "contact_us": contactUs,
    "brands": brands,
    "categories": categories,
    "customer_account": customerAccount,
  };
}
