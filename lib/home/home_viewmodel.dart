import 'dart:convert';

import 'package:app_development_test/home/category_model.dart';
import 'package:app_development_test/home/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class HomeViewModel extends GetxController {
  RxInt selectedIndex = 0.obs;
  List<CategoryModel> categoriesList = <CategoryModel>[].obs;
  List<ProductModel> allProductsList = <ProductModel>[].obs;
  List<ProductModel> filteredProductsList = <ProductModel>[].obs;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void onReady() {
    loadData();
    super.onReady();
  }

  loadData() {
    firestore.collection('Shop').get().then((data) {
      if (data.docs.isNotEmpty) {
        for (QueryDocumentSnapshot item in data.docs) {
          categoriesList
              .add(CategoryModel.fromJson(item.data() as Map<String, dynamic>));
          print(item.data());
        }

        categoriesList.sort((a, b) => a.categoryId!.compareTo(b.categoryId!));
        loadCategories();
      }
    });
  }

  loadCategories() {
    ///
    firestore.collectionGroup('products').get().then((data) {
      if (data.docs.isNotEmpty) {
        for (QueryDocumentSnapshot item in data.docs) {
          print(jsonEncode(item.data()));
          allProductsList
              .add(ProductModel.fromJson(item.data() as Map<String, dynamic>));
        }

        filteredProductsList.addAll(allProductsList.where((e) =>
            e.categoryId == categoriesList[selectedIndex.value].categoryId));

        print(allProductsList.where((e) =>
        e.categoryId == categoriesList[selectedIndex.value].categoryId).length);
        print(categoriesList[selectedIndex.value].categoryId);
      }
    });
  }

  filterData(){
    filteredProductsList.clear();
    filteredProductsList.addAll(allProductsList.where((e) =>
    e.categoryId == categoriesList[selectedIndex.value].categoryId));
  }
}
