import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable()
class Product {
  int? id;
  String? name, description, slug, price, base_64_qr_code;

  Product({
    this.id,
    this.name,
    this.base_64_qr_code,
    this.description,
    this.price,
    this.slug,
  });

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
