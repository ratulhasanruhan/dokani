import 'package:get/get.dart';
import '../controller/product_controller.dart';

class ProductListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProductListController());
  }
}