import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/layout/shop_app_layout.dart';
import 'package:shop_app/models/get_cart.dart';
import 'package:shop_app/modules/products/product_details/product_details.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/constants/constants.dart';

class ShoppingCart extends StatelessWidget {
  static const String shoppingCartRoute = '/cart';

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Shopping Cart'),
          ),
          body: Conditional.single(
            context: context,
            conditionBuilder: (context) => state is! ShopLoadingGetCartState,
            widgetBuilder: (context) {
              return (ShopCubit.get(context)
                          .getCart!
                          .cartDetails!
                          .products
                          .length !=
                      0)
                  ? Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          topRight: Radius.circular(30.0),
                        ),
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            flex: 6,
                            child: ListView.separated(
                              padding: EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 10),
                              itemBuilder: (context, index) => buildInCartIteam(
                                  ShopCubit.get(context)
                                      .getCart!
                                      .cartDetails!
                                      .products[index],
                                  context, () {
                                ShopCubit.get(context).getProductDetails(
                                    ShopCubit.get(context)
                                        .getCart!
                                        .cartDetails!
                                        .products[index]
                                        .product!
                                        .id);
                                Navigator.of(context).pushNamed(
                                  ProductDetails.productDetailsScreen,
                                );
                              }),
                              separatorBuilder: (context, index) => SizedBox(
                                height: 10.0,
                              ),
                              itemCount: ShopCubit.get(context)
                                  .getCart!
                                  .cartDetails!
                                  .products
                                  .length,
                            ),
                          ),
                          if (state is ShopLoadingDeleteProductFromCartState ||
                              state is ShopLoadingUpdateQuantityState ||
                              state is ShopLoadingGetCartState)
                            LinearProgressIndicator(
                              color: Colors.deepPurpleAccent,
                            ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30.0),
                                  topRight: Radius.circular(30.0),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      priceFix(ShopCubit.get(context)
                                          .getCart!
                                          .cartDetails!
                                          .total
                                          .toString()),
                                      style: TextStyle(
                                        fontSize: 25.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10.0),
                                      child: buildMainButton(
                                        label: 'Check Out',
                                        onPressed: () {},
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/empty_cart.png',
                            height: 250,
                            width: 250,
                          ),
                          Text(
                            'Cart is EMPTY',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Check our product and order now!',
                            style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.deepPurple,
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: buildMainButton(
                                label: 'Check Products',
                                onPressed: () {
                                  Navigator.of(context).pushReplacementNamed(
                                    ShopLayout.shopLayoutRoute,
                                  );
                                },
                                size: 150),
                          ),
                        ],
                      ),
                    );
            },
            fallbackBuilder: (context) => Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );
  }

  Widget buildInCartIteam(ProductInCart model, context, onPressed) {
    return InkWell(
      onTap: onPressed,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            //height: 150,
            padding: EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 20.0,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.deepPurpleAccent),
                    borderRadius: BorderRadius.circular(20.0),
                    image: DecorationImage(
                      image: NetworkImage(model.product!.image),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        '${model.product!.name}',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              priceFix(model.product!.price.toString()),
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.deepPurple,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 15,
                                child: IconButton(
                                  onPressed: () {
                                    ShopCubit.get(context)
                                        .updateQuantityOfInCartProduct(
                                            model.inCartID, model.quantity + 1);
                                  },
                                  icon: Icon(
                                    Icons.add,
                                    size: 15,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                '${model.quantity}',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              CircleAvatar(
                                radius: 15,
                                child: IconButton(
                                  onPressed: () {
                                    if (model.quantity > 1) {
                                      ShopCubit.get(context)
                                          .updateQuantityOfInCartProduct(
                                              model.inCartID,
                                              model.quantity - 1);
                                    }
                                  },
                                  icon: Icon(
                                    Icons.remove,
                                    size: 15,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          IconButton(
                            onPressed: () {
                              ShopCubit.get(context)
                                  .deleteProductFromCart(model.inCartID);
                            },
                            icon: Icon(
                              Icons.delete_forever,
                              color: Colors.red[800],
                              size: 30,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
