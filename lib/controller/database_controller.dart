import 'package:ecommerce/models/add_to_cart_model.dart';
import 'package:ecommerce/models/product.dart';
import 'package:ecommerce/models/user_data.dart';
import 'package:ecommerce/services/firestore_services.dart';
import 'package:ecommerce/utils/api_path.dart';

abstract class Database {
  Stream<List<Product>> salesProductsStream();
  Stream<List<Product>> newProductsStream();
  Stream<List<AddToCartModel>> myProductsCart();

  Future<void> setUserData(UserData userData);
  Future<void> addToCart(AddToCartModel product);
}

class FirestoreDatabase implements Database {
  final String uid;
  final _service = FirestoreServices.instance;
  FirestoreDatabase(this.uid);
  @override
  Stream<List<Product>> salesProductsStream() => _service.collectionsStram(
    path: ApiPath.products(),
    builder: (data, documentId) => Product.fromMap(data!, documentId),
    queryBuilder: (query) => query.where('discountValue', isNotEqualTo: 0),
  );

  @override
  Stream<List<Product>> newProductsStream() => _service.collectionsStram(
    path: ApiPath.products(),
    builder: (data, documentId) => Product.fromMap(data!, documentId),
  );

  Future<void> setProduct(Product product) async =>
      _service.setData(path: "products/${product.id}", data: product.toMap());

  @override
  Future<void> setUserData(UserData userData) async => await _service.setData(
    path: ApiPath.user(userData.uid),
    data: userData.toMap(),
  );

  @override
  Future<void> addToCart(AddToCartModel product) async =>
      await _service.setData(
        path: ApiPath.addToCartId(uid, product.id),
        data: product.toMap(),
      );

  @override
  Stream<List<AddToCartModel>> myProductsCart() => _service.collectionsStram(
    path: ApiPath.myProductsCart(uid),
    builder: (data, documentId) => 
    AddToCartModel.fromMap(data!, documentId),
  );
}
