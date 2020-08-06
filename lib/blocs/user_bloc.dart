import 'dart:async';

import 'package:dekornata_submission_test/models/add_product.dart';
import 'package:dekornata_submission_test/models/product.dart';
import 'package:dekornata_submission_test/models/user.dart';
import 'package:dekornata_submission_test/services/user_service.dart';
import 'package:rxdart/rxdart.dart';

class UserBloc {
  final UserService _service;

  StreamController<UpdateUserEvent> updateUserInformationSink = StreamController<UpdateUserEvent>();
  StreamController<NewUserProductEvent> addNewProductToUserProductsSink =
      StreamController<NewUserProductEvent>();

  Stream<ECommerceUser> get user => _userStreamController.stream;
  StreamController _userStreamController = BehaviorSubject<ECommerceUser>(
      seedValue: ECommerceUser(name: "Ahmad Ruslan", contact: "aruslan8395@gmail.com"));

  UserBloc(this._service) {
    updateUserInformationSink.stream.listen(_handleNewUserInformation);
    addNewProductToUserProductsSink.stream.listen(_handleNewUserProduct);
    _service.streamUserInformation().listen((ECommerceUser data) {
      _userStreamController.add(data);
    });
  }

  void _handleNewUserInformation(UpdateUserEvent event) {
    event.user.userProducts = [];
    _service.updateUserInformation(event.user);
  }

  _handleNewUserProduct(NewUserProductEvent event) {
    var product = Product(
      category: event.product.category,
      title: event.product.title,
      cost: event.product.cost,
      imageTitle: ImageTitle.AiraTray,
    );
    _service.addUserProduct(product);
  }

  close() {
    updateUserInformationSink.close();
    addNewProductToUserProductsSink.close();
    _userStreamController.close();
  }
}
