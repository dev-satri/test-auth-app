import 'dart:convert';

///Make use of https://app.quicktype.io/ is you find it difficult to create model class manually

List<ProductModel> productModelFromJson(String str) => List<ProductModel>.from(
  json.decode(str).map((x) => ProductModel.fromJson(x)),
);

String productModelToJson(List<ProductModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductModel {
  String? id;
  String? productTitle;
  String? productDesc;
  int? availableStock;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  ProductModel({
    this.id,
    this.productTitle,
    this.productDesc,
    this.availableStock,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  ProductModel copyWith({
    String? id,
    String? productTitle,
    String? productDesc,
    int? availableStock,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? v,
  }) => ProductModel(
    id: id ?? this.id,
    productTitle: productTitle ?? this.productTitle,
    productDesc: productDesc ?? this.productDesc,
    availableStock: availableStock ?? this.availableStock,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    v: v ?? this.v,
  );

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    id: json["_id"],
    productTitle: json["productTitle"],
    productDesc: json["productDesc"],
    availableStock: json["availableStock"],
    createdAt:
        json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt:
        json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "productTitle": productTitle,
    "productDesc": productDesc,
    "availableStock": availableStock,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}
