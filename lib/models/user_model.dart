class UserModel {
  int uid;
  String name;
  String email;
  String surname;
  String phone;
  String street;
  String area;
  String address;
  bool? subscription_profile;
  String? orderCount;

  UserModel(
      {required this.uid,
      required this.name,
      required this.email,
      required this.phone,
      required this.surname,
      required this.street,
      required this.address,
      required this.area,
      this.subscription_profile,
      this.orderCount});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        uid: json['uid'],
        name: json['f_name'],
        email: json['email'],
        phone: json['phone'],
        area: json['area'],
        street: json['street'],
        address: json['address'],
        surname: json['surname'],
        subscription_profile: json['subscription_profile'],
        orderCount: json['order_count']);
  }
}
