import 'package:ecommerce/utils/assets.dart';

class Product {
  final String id;
  final String title;
  final int price;
  final String imageUrl;
  final int discountValue;
  final String category;
  final double? rate;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.imageUrl,
    this.discountValue = 0,
    this.category = "Other",
    this.rate,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'imageUrl': imageUrl,
      'discountValue': discountValue,
      'category': category,
      'rate': rate,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map, String documentId) {
    return Product(
      id: documentId,
      title: map["title"] as String,
      price: map["price"] as int,
      imageUrl: map["imageUrl"] as String,
      discountValue: map["discountValue"] as int,
      category: map["category"] as String,
      rate: map["rate"] as double,
    );
  }
}

List<Product> dummyProducts = [
  Product(
    id: "1",
    title: "T-Shirt",
    price: 300,
    imageUrl: AppAssets.tempProductAsset1,
    category: "Clothes",
    discountValue: 20,
  ),
  Product(
    id: "1",
    title: "T-Shirt",
    price: 300,
    imageUrl: AppAssets.tempProductAsset1,
    category: "Clothes",
    discountValue: 20,
  ),
  Product(
    id: "1",
    title: "T-Shirt",
    price: 300,
    imageUrl: AppAssets.tempProductAsset1,
    category: "Clothes",
    discountValue: 20,
  ),
  Product(
    id: "1",
    title: "T-Shirt",
    price: 300,
    imageUrl: AppAssets.tempProductAsset1,
    category: "Clothes",
    discountValue: 20,
  ),
  Product(
    id: "1",
    title: "T-Shirt",
    price: 300,
    imageUrl: AppAssets.tempProductAsset1,
    category: "Clothes",
    discountValue: 20,
  ),
  Product(
    id: "1",
    title: "T-Shirt",
    price: 300,
    imageUrl: AppAssets.tempProductAsset1,
    category: "Clothes",
  ),
  Product(
    id: "1",
    title: "T-Shirt",
    price: 300,
    imageUrl: AppAssets.tempProductAsset1,
    category: "Clothes",
    discountValue: 20,
  ),
];
