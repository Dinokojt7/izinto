class UserModel {
  final String uid;
  final String? name;
  final String? surname;
  final String? phone;
  final String? email;
  final String? address;
  final String? subStatus;
  final int? orderHistory;
  // final String metadata;

  UserModel(
      {this.address,
      this.surname,
      this.subStatus,
      this.email,
      this.phone,
      this.name,
      this.orderHistory,
      required this.uid});
}
