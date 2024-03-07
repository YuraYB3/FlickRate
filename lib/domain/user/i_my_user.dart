import '../ibase_model.dart';

abstract interface class IMyUser implements IBaseModel {
  final String email;
  final String userId;
  IMyUser(this.email, this.userId);
}
