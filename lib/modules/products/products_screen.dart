import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/modules/products/product_details/product_details.dart';
import 'package:shop_app/modules/shopping_cart/shopping_cart.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/constants/constants.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print(token);
    return BlocConsumer<ShopCubit, ShopAppStates>(
      listener: (context, state) {
        if (state is ShopSuccessChangeFavoritesState) {
          if (!state.model.status) {
            showToast(message: state.model.message);
          }
        }
      },
      builder: (context, state) {
        return Conditional.single(
          context: context,
          conditionBuilder: (context) =>
              ShopCubit.get(context).homeModel != null &&
              ShopCubit.get(context).categoriesModel != null,
          widgetBuilder: (context) => productBuilder(
              ShopCubit.get(context).homeModel,
              ShopCubit.get(context).categoriesModel,
              context),
          fallbackBuilder: (context) => Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}

Widget productBuilder(
    HomeModel? model, CategoriesModel? categoriesModel, BuildContext context) {
  return Container(
    color: Colors.grey[200],
    padding: EdgeInsets.symmetric(horizontal: 10.0),
    child: SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          SizedBox(
            height: 20.0,
          ),
          CarouselSlider(
            items: model!.data.banners
                .map((e) => ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image(
                        image: NetworkImage('${e.image}'),
                        fit: BoxFit.cover,
                        height: 200.0,
                      ),
                    ))
                .toList(),
            options: CarouselOptions(
              viewportFraction: 1.0,
              height: 200.0,
              autoPlay: true,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(seconds: 1),
              autoPlayCurve: Curves.easeInBack,
              scrollDirection: Axis.horizontal,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          seeAll(
              onPressed: ShopCubit.get(context).incIndex, title: 'Categories'),
          SizedBox(
            height: 10.0,
          ),
          Container(
            height: 125,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) => buildCategoryItem(
                image: categoriesModel!.data.categories[index].image,
                name: categoriesModel.data.categories[index].name,
              ),
              separatorBuilder: (context, index) => SizedBox(
                width: 15.0,
              ),
              itemCount: categoriesModel!.data.categories.length,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          seeAll(onPressed: () {}, title: 'New Products'),
          SizedBox(
            height: 10.0,
          ),
          GridView.count(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 1 / 1.77,
            children: List.generate(
                model.data.products.length,
                (index) =>
                    buildGridProduct(model.data.products[index], context, () {
                      ShopCubit.get(context)
                          .getProductDetails(model.data.products[index].id);
                      Navigator.of(context).pushNamed(
                        ProductDetails.productDetailsScreen,
                      );
                    })),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Keep up to our new products and sales..',
            style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            ),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    ),
  );
}

Widget buildGridProduct(
    ProductModel model, context, void Function() onPressed) {
  return InkWell(
    onTap: onPressed,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Container(
                color: Colors.white,
                child: Image(
                  image: NetworkImage(model.image),
                  width: double.infinity,
                  height: 200.0,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 5.0, top: 5.0),
              width: 40.0,
              height: 40.0,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Center(
                child: IconButton(
                  icon: Icon(
                    ShopCubit.get(context).favorites[model.id]!
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: ShopCubit.get(context).favorites[model.id]!
                        ? Colors.deepPurpleAccent
                        : Colors.grey[800],
                  ),
                  onPressed: () {
                    ShopCubit.get(context).changeFavorites(model.id);
                  },
                ),
              ),
            ),
            if (model.discount != 0)
              Positioned(
                bottom: 10.0,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.0),
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(5.0),
                        bottomRight: Radius.circular(5.0),
                      )),
                  child: Text(
                    'DISCOUNT',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
          ],
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          model.name,
          style: TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
          ),
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          textAlign: TextAlign.start,
        ),
        SizedBox(
          height: 5,
        ),
        Row(
          children: [
            Text(
              priceFix(model.price.toString()),
              style: TextStyle(
                fontSize: 17.0,
                color: Colors.deepPurple,
                fontWeight: FontWeight.bold,
                decorationStyle: TextDecorationStyle.dashed,
              ),
            ),
            SizedBox(
              width: 10.0,
            ),
            if (model.discount != 0)
              Text(
                priceFix(model.oldPrice.round().toString()),
                style: TextStyle(
                  fontSize: 14.0,
                  decoration: TextDecoration.lineThrough,
                  color: Colors.grey,
                ),
                overflow: TextOverflow.ellipsis,
              ),
          ],
        ),
        SizedBox(
          height: 5.0,
        ),
        buildAddToCartButton(
          label: 'Add to Cart',
          onPressed: () {
            ShopCubit.get(context).addProductToCart(model.id);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text('Added to cart successfully!'),
                action: SnackBarAction(
                  textColor: Colors.white,
                  label: 'Go to Cart',
                  onPressed: () {
                    ShopCubit.get(context).getInCartProducts();
                    Navigator.of(context).pushNamed(
                      ShoppingCart.shoppingCartRoute,
                    );
                  },
                ),
              ),
            );
          },
        ),
      ],
    ),
  );
}

Widget buildCategoryItem({
  required String image,
  required String name,
}) {
  return Container(
    height: 125.0,
    width: 80.0,
    child: Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Image(
            image: NetworkImage(image),
            fit: BoxFit.cover,
            height: 80.0,
            width: 80.0,
          ),
        ),
        SizedBox(
          height: 5.0,
        ),
        Text(
          name,
          style: TextStyle(
            //color: Colors.white,
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
          ),
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          maxLines: 2,
        ),
      ],
    ),
  );
}
