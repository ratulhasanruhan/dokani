import 'package:dokani/screen/ProductList.dart';
import 'package:get/get.dart';

import '../screen/ProductDetailsView.dart';
import 'binding.dart';

class AppRoutes {
  static const home = '/';
  static const details = '/details';

  static final routes = [
    GetPage(
      name: home,
      page: () => const ProductList(),
      binding: ProductListBinding(),
    ),
    GetPage(
      name: details,
      page: () => const ProductDetailsView(),
      transition: Transition.fadeIn,
      transitionDuration: Duration(milliseconds: 500),
    ),
  ];
}
