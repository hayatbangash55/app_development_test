import 'package:app_development_test/product_detail/product_detail_viewmodel.dart';
import 'package:app_development_test/widgets/custom_buttons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetailView extends StatelessWidget {
  ProductDetailView({Key? key}) : super(key: key);
  final ProductDetailViewModel viewModel = Get.put(ProductDetailViewModel());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            productImage(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  productTitlePrice(),
                  const SizedBox(height: 4),
                  const Text(
                    '(with solo app)',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: Color(0xff695D5D),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Text(
                      'colors',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  colorListView(),
                  const SizedBox(height: 30),
                  Row(
                    children: const [
                      Text(
                        'Detail',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          color: Color(0xff827E7E),
                        ),
                      ),
                      SizedBox(width: 20),
                      Text(
                        'Reviews',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          color: Color(0xff827E7E),
                        ),
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 35),
                    child: Text(
                      'What is a case study? A case study is a research approach that is used to generate an in-depth, multi-faceted understanding of a complex issue in its real-life context. It is an established research design that is used extensively in a wide variety of disciplines,',
                      style: TextStyle(
                        color: Color(0xffAAA0A0),
                        fontSize: 15,
                      ),
                    ),
                  ),
                  addToCartButton(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget productImage() {
    return Stack(
      children: [
        Container(
          color: const Color(0xffECF6F6),
          child: CachedNetworkImage(
            width: double.infinity,
            height: Get.height * 0.25,
            imageUrl: '',
            imageBuilder: (context, imageProvider) {
              return Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.fill,
                  ),
                ),
              );
            },
            errorWidget: (context, url, error) {
              return Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
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
          ),
        ),
        Material(
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(CupertinoIcons.arrow_left),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(CupertinoIcons.heart),
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget productTitlePrice() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        Expanded(
          child: Text(
            'Apple watch series 7',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20,
            ),
          ),
        ),
        Text(
          '\$2000',
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 24,
              color: Color(0xff5534A5)),
        )
      ],
    );
  }

  Widget colorListView() {
    return Obx(
      () => SizedBox(
        height: 50,
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: viewModel.colorList.length,
          itemBuilder: (BuildContext context, int index) {
            return colorListItem(index);
          },
        ),
      ),
    );
  }

  Widget colorListItem(int index) {
    return Obx(() => Container(
          margin: const EdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: viewModel.selectedColorIndex.value == index
                  ? Colors.black
                  : const Color(0xffCCBCBC),
            ),
          ),
          child: InkWell(
            onTap: () {
              viewModel.selectedColorIndex.value = index;
            },
            borderRadius: BorderRadius.circular(15),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Row(
                children: [
                  Icon(
                    Icons.circle,
                    color: viewModel.colorList[index].color,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    viewModel.colorList[index].name,
                    style: const TextStyle(
                      color: Color(0xffBAAAAA),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Widget addToCartButton() {
    return CustomTextBtn(
      radius: 21,
      height: 60,
      backgroundColor: const Color(0xff004EDA),
      child: const Text(
        'Add To Cart',
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
      onPressed: () {},
    );
  }
}
