import 'package:flutter/material.dart';
import 'package:shop_app/layout/cubit/cubit.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[100],
      child: SingleChildScrollView(
        padding: EdgeInsets.all(15.0),
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Categories',
              style: TextStyle(
                fontSize: 30.0,
                color: Colors.deepPurple,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              crossAxisSpacing: 15,
              mainAxisSpacing: 10,
              physics: BouncingScrollPhysics(),
              children: List.generate(
                ShopCubit.get(context).categoriesModel!.data.categories.length,
                (index) => buildCategoryItem(
                  image: ShopCubit.get(context)
                      .categoriesModel!
                      .data
                      .categories[index]
                      .image,
                  name: ShopCubit.get(context)
                      .categoriesModel!
                      .data
                      .categories[index]
                      .name,
                  context: context,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildCategoryItem({
  required String image,
  required String name,
  required BuildContext context,
}) =>
    Stack(
      children: [
        ClipRRect(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Colors.deepPurple,
                width: 1,
              ),
            ),
            child: Image.network(
              image,
              width: MediaQuery.of(context).size.width / 2,
              height: 180.0,
              fit: BoxFit.cover,
            ),
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        Positioned(
          bottom: 40.0,
          child: Container(
            color: Colors.black45,
            padding: EdgeInsets.symmetric(vertical: 5.0),
            width: MediaQuery.of(context).size.width / 2,
            child: Center(
              child: Text(
                name,
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
      ],
    );
