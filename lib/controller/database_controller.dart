import 'package:ecommerce/models/product.dart';
import 'package:ecommerce/models/user_data.dart';
import 'package:ecommerce/services/firestore_services.dart';
import 'package:ecommerce/utils/api_path.dart';

abstract class Database {
  Stream<List<Product>> salesProductsStream();
  Stream<List<Product>> newProductsStream();

  Future<void> setUserData(UserData userData);
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
  Future<void> setUserData(UserData userData) async=>
     await _service.setData(path: ApiPath.user(userData.uid), data: userData.toMap());
}
