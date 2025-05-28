import 'package:espress_yo_self/domain/entities/product_entity.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_model.freezed.dart';
part 'product_model.g.dart';

@freezed
abstract class ProductModel with _$ProductModel {
  const factory ProductModel({
    required String id,
    required String name,
    required String description,
    required String price,
    required String category,
    @JsonKey(name: 'image_url') required String imageUrl,
    @JsonKey(name: 'image_250_url') required String image250Url,
    required String? discount,
  }) = _ProductModel;

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);
}

extension ProductModelMapper on ProductModel {
  ProductEntity toEntity() => ProductEntity(
      id: id,
      name: name,
      description: description,
      price: price,
      category: category,
      imageUrl: imageUrl,
      image250Url: image250Url,
      discount: discount);

  static ProductModel fromEntity(ProductEntity entity) => ProductModel(
        id: entity.id,
        name: entity.name,
        description: entity.description,
        price: entity.price,
        category: entity.category,
        imageUrl: entity.imageUrl,
        image250Url: entity.image250Url,
        discount: entity.discount,
      );
}
