import 'package:app_development_test/home/product_model.dart';
import 'package:app_development_test/product_detail/color_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetailViewModel extends GetxController {
  List<ColorModel> colorList = <ColorModel>[
    ColorModel(name: 'chalk pink', color: const Color(0xffDA7777)),
    ColorModel(name: 'light pink', color: const Color(0xffEB55C1)),
    ColorModel(name: 'dark order', color: const Color(0xff676060)),
  ].obs;
  RxInt selectedColorIndex = 0.obs;

  Rx<ProductModel> product = ProductModel().obs;

  @override
  void onReady() {
    product.value = Get.arguments['product'];
    super.onReady();
  }
}
