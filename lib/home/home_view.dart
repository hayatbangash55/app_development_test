import 'package:app_development_test/home/home_viewmodel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);
  final HomeViewModel viewModel = Get.put(HomeViewModel());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffECF6F6),
        body: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            children: [
              Row(
                children: [
                  menuButton(),
                  searchTextField(),
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(top: 30, bottom: 70),
                child: Text(
                  'find your suitable watch now.',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 36,
                  ),
                ),
              ),
              categoriesListView(),
              gridList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget menuButton() {
    return Expanded(
      flex: 1,
      child: Align(
        alignment: Alignment.centerLeft,
        child: IconButton(
          iconSize: 40,
          visualDensity: VisualDensity.compact,
          onPressed: () {},
          icon: const Icon(
            Icons.menu,
          ),
        ),
      ),
    );
  }

  Widget searchTextField() {
    return Expanded(
      flex: 2,
      child: TextFormField(
        decoration: InputDecoration(
          prefixIcon: const Padding(
            padding: EdgeInsets.only(left: 10),
            child: Icon(
              Icons.search_rounded,
              size: 32,
              color: Color(0xff1E1D1D),
            ),
          ),
          fillColor: Colors.white,
          hintText: 'search product',
          contentPadding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
          hintStyle: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 20,
            color: Color(0xff757575),
          ),
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0XFF757575)),
            borderRadius: BorderRadius.circular(
              30,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0XFF757575), width: 1.3),
            borderRadius: BorderRadius.circular(30),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red.shade700),
            borderRadius: BorderRadius.circular(30),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red.shade700, width: 1.5),
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }

  Widget categoriesListView() {
    return SizedBox(
      height: 35,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return categoriesViewItem(index);
        },
      ),
    );
  }

  Widget categoriesViewItem(int index) {
    return InkWell(
      onTap: () {
        viewModel.selectedIndex.value = index;
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 2,
              color: Color(0xff004EDA),
            ),
          ),
        ),
        child: Text(
          'abcdef',
          style: TextStyle(
            color: viewModel.selectedIndex.value == index
                ? const Color(0xff004EDA)
                : const Color(0xff988888),
            fontSize: 20,
          ),
        ),
      ),
    );
  }

  Widget gridList() {
    return Expanded(
      child: GridView.builder(
        itemCount: 6,
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1,
          crossAxisSpacing: 10,
          mainAxisSpacing: 15,
        ),
        itemBuilder: (BuildContext context, int index) {
          return gridViewItem(index);
        },
      ),
    );
  }

  Widget gridViewItem(int index) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          productImage(index),
          const Text(
            'Apple Watch',
            style: TextStyle(
              color: Color(0xff0F1010),
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Text(
            'series 1',
            style: TextStyle(
              color: Color(0xff0F1010),
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Text(
            '\$123',
            style: TextStyle(
              color: Color(0xff0F1010),
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget productImage(int index) {
    return CachedNetworkImage(
      height: 100,
      imageUrl:
          '',
      imageBuilder: (context, imageProvider) {
        return Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
        );
      },
      errorWidget: (context, url, error) {
        return Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/carImage.jfif'),
              fit: BoxFit.fill,
            ),
          ),
        );
      },
      placeholder: (context, url) {
        return const Center(
          child: CircularProgressIndicator(strokeWidth: 2.0),
        );
      },
    );
  }
}
