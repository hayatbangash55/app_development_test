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
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 25, right: 25, top: 20),
              child: Row(
                children: [
                  menuButton(),
                  searchTextField(),
                ],
              ),
            ),
            const Padding(
              padding:
                  EdgeInsets.only(top: 25, bottom: 40, left: 20, right: 20),
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
    return Obx(
      () => SizedBox(
        height: 40,
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: viewModel.categoriesList.length,
          itemBuilder: (BuildContext context, int index) {
            return categoriesViewItem(index);
          },
        ),
      ),
    );
  }

  Widget categoriesViewItem(int index) {
    return InkWell(
      onTap: () {
        viewModel.selectedIndex.value = index;
        viewModel.filterData();
      },
      child: Container(
        padding: const EdgeInsets.only(top: 5),
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 2,
              color: Color(0xff004EDA),
            ),
          ),
        ),
        child: Text(
          '${viewModel.categoriesList[index].categoryName}',
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
    return Obx(
      () => Expanded(
        child: GridView.builder(
          itemCount: viewModel.filteredProductsList.length,
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.75,
            crossAxisSpacing: 13,
            mainAxisSpacing: 15,
          ),
          itemBuilder: (BuildContext context, int index) {
            return gridViewItem(index);
          },
        ),
      ),
    );
  }

  Widget gridViewItem(int index) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(14),
        child: Padding(
          padding: const EdgeInsets.all(6),
          child: Column(
            children: [
              productImage(index),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(5),
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        viewModel.filteredProductsList[index].title ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Color(0xff0F1010),
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        viewModel.filteredProductsList[index].subtitle ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Color(0xff7A7474),
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          '\$${viewModel.filteredProductsList[index].price ?? '0'}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget productImage(int index) {
    return CachedNetworkImage(
      height: 110,
      imageUrl: viewModel.filteredProductsList[index].image ?? '',
      imageBuilder: (context, imageProvider) {
        return Container(
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xffB8A6A6)),
            borderRadius: BorderRadius.circular(14),
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
        );
      },
      errorWidget: (context, url, error) {
        return Container(
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xffB8A6A6)),
            borderRadius: BorderRadius.circular(14),
            image: const DecorationImage(
              image: AssetImage('assets/images/default_image.png'),
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
