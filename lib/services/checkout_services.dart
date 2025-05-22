import 'package:ecommerce/models/payment_method.dart';
import 'package:ecommerce/services/auth.dart';
import 'package:ecommerce/services/firestore_services.dart';
import 'package:ecommerce/utils/api_path.dart';

abstract class CheckoutServices {
  Future<void> setPaymentMethod(PaymentMethod paymentMethod);
  Future<void> deletePaymentMethod(PaymentMethod paymentMethod);
  Future<List<PaymentMethod>> paymentMethods();
}

class CheckoutServicesImp implements CheckoutServices {
  final firestoreServices = FirestoreServices.instance;
  final authServices = Auth();

  @override
  Future<void> setPaymentMethod(PaymentMethod paymentMethod) async {
    final currentUser = authServices.currentUser;
    await firestoreServices.setData(
      path: ApiPath.addCard(currentUser!.uid, paymentMethod.id),
      data: paymentMethod.toMap(),
    );
  }

  @override
  Future<void> deletePaymentMethod(PaymentMethod paymentMethod) async {
    final currentUser = authServices.currentUser;
    await firestoreServices.deleteData(
      path: ApiPath.addCard(currentUser!.uid, paymentMethod.id),
    );
  }

  @override
  Future<List<PaymentMethod>> paymentMethods([
    bool fetchPreferred = false,
  ]) async {
    final currentUser = authServices.currentUser;

    return await firestoreServices.getCollection(
      path: ApiPath.cards(currentUser!.uid),
      builder: (data, documentId) => PaymentMethod.fromMap(data),
      queryBuilder:
          fetchPreferred == true
              ? (query) => query.where('isPreferred', isEqualTo: true)
              : null,
    );
  }
}
