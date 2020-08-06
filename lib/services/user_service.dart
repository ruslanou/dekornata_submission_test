import 'package:dekornata_submission_test/models/product.dart';
import 'package:dekornata_submission_test/models/user.dart';
import 'package:dekornata_submission_test/storage/mock_store.dart';

abstract class UserService {
  Stream<ECommerceUser> streamUserInformation();
  Future addUserProduct(Product product);
  Future updateUserInformation(ECommerceUser user);
}

class MockUserService implements UserService {
  final AppStore store;
  MockUserService(this.store);

  @override
  Stream<ECommerceUser> streamUserInformation() {
    return store.userNotifier.stream.map((_) => store.user);
  }

  @override
  Future addUserProduct(Product product) async {
    store.user.userProducts.add(product);
  }

  @override
  Future updateUserInformation(ECommerceUser user) async {
    store.user = user;
  }
}