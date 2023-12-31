import 'package:get/get.dart';

import '../helpers/data/repository/recommended_specialty_repo.dart';
import '../models/popular_specialty_model.dart';
import 'cart_controller.dart';

class RecommendedSpecialtyController extends GetxController {
  final RecommendedSpecialtyRepo recommendedSpecialtyRepo;
  RecommendedSpecialtyController({required this.recommendedSpecialtyRepo});
  List<dynamic> _recommendedSpecialtyList = [];
  List<dynamic> _areaList = [];
  List<dynamic> _otherList = [];
  List<dynamic> get recommendedSpecialtyList => _recommendedSpecialtyList;
  List<dynamic> get areaList => _areaList;
  List<dynamic> get otherList => _otherList;
  late CartController _cart;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  int _quantity = 0;
  int get quantity => _quantity;
  int _inCartItems = 0;
  int get inCartItems => _inCartItems + _quantity;

  Future<void> getRecommendedSpecialtyList() async {
    Response response =
        await recommendedSpecialtyRepo.getRecommendedSpecialtyList();
    if (response.statusCode == 200) {
      _recommendedSpecialtyList = [];
      _otherList = [];
      _areaList = [];
      _recommendedSpecialtyList
          .addAll(Specialty.fromJson(response.body).specialties);
      // _otherList
      //     .addAll(OtherSpecialty.fromJson(response.body).otherSpecialties);
      _areaList.addAll(AreaSpecialty.fromJson(response.body).areaSpecialties);

      _isLoaded = true;
      update();
    } else {
      print('this is not working ${response.statusCode}');
    }
  }

  void setQuantity(bool isIncrement) {
    if (isIncrement) {
      _quantity = checkQuantity(_quantity + 1);
    } else {
      _quantity = checkQuantity(_quantity - 1);
    }
    update();
  }

  int checkQuantity(int quantity) {
    if ((_inCartItems + quantity) < 0) {
      Get.snackbar(
        'Item count 0', 'You don\'t have items',
        // backgroundColor: AppColors.mainColor, colorText: Colors.white
      );
      if (_inCartItems > 0) {
        _quantity = -_inCartItems;
        return _quantity;
      }
      return 0;
    } else if ((_inCartItems + quantity) > 20) {
      Get.snackbar('Item count 20', 'Maximum number of items selected');
      return 20;
    } else {
      return quantity;
    }
  }

  void initSpecialty(SpecialtyModel specialty, CartController cart) {
    _quantity = 0;
    _inCartItems = 0;
    _cart = cart;
    var exist = false;
    exist = _cart.existInCart(SpecialtyModel, specialty);
    //if exist
    //get from storage _inCartItems=3
    // print('exist or not ' + exist.toString());
    if (exist) {
      _inCartItems = _cart.getQuantity(specialty);
    }
    // print('The quantity in the cart is ' + _inCartItems.toString());
  }

  void addItem(SpecialtyModel specialty) {
    _cart.addItem(specialty, _quantity);

    _quantity = 0;
    _inCartItems = _cart.getQuantity(specialty);

    _cart.items.forEach((key, value) {
      // print('The id is ' +
      //     value.id.toString() +
      //     ' The quantity is ' +
      //     value.quantity.toString());
    });

    update();
  }

  int get totalItems {
    return _cart.totalItems;
  }
}
