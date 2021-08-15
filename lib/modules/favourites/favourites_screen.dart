import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/favorites_model.dart';

class FavouritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Conditional.single(
            context: context,
            conditionBuilder: (context) =>
                state is! ShopLoadingGetFavoritesDataState,
            fallbackBuilder: (context) => Center(
                  child: CircularProgressIndicator(
                    color: Colors.deepPurple,
                  ),
                ),
            widgetBuilder: (context) {
              return (ShopCubit.get(context).favoritesModel!.data.data.length !=
                      0)
                  ? Container(
                      color: Colors.grey[100],
                      child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) => BuildFavoriteItem(
                            ShopCubit.get(context)
                                .favoritesModel!
                                .data
                                .data[index],
                            context),
                        separatorBuilder: (context, index) => Container(
                          margin: EdgeInsets.symmetric(horizontal: 10.0),
                          height: 1,
                          color: Colors.grey[300],
                        ),
                        itemCount: ShopCubit.get(context)
                            .favoritesModel!
                            .data
                            .data
                            .length,
                      ),
                    )
                  : Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 200,
                            width: 200,
                            child: Image.asset(
                              'assets/images/empty_favorites.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                          Text(
                            'No Favorites yet,',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                child: Text(
                                  'Click Here',
                                  style: TextStyle(
                                    color: Colors.deepPurple,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                onTap: () {
                                  ShopCubit.get(context).changeBottomNavBar(0);
                                },
                              ),
                              Text(
                                ', to see our products.',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
            });
      },
    );
  }
}

Widget BuildFavoriteItem(FavoritesData model, context) => Container(
      height: 130.0,
      padding: EdgeInsets.all(10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Container(
                  color: Colors.white,
                  child: Image(
                    image: NetworkImage(model.product.image),
                    width: 140.0,
                    height: 120.0,
                  ),
                ),
              ),
              if (model.product.discount != 0)
                Positioned(
                  bottom: 10.0,
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.0),
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
            width: 10.0,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.product.name,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  textAlign: TextAlign.start,
                ),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${model.product.price} L.E',
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
                        if (model.product.discount != 0)
                          Text(
                            '${model.product.oldPrice} L.E',
                            style: TextStyle(
                              fontSize: 14.0,
                              decoration: TextDecoration.lineThrough,
                              color: Colors.grey,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                      ],
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
                            ShopCubit.get(context).favorites[model.product.id]!
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: ShopCubit.get(context)
                                    .favorites[model.product.id]!
                                ? Colors.deepPurpleAccent
                                : Colors.grey[800],
                          ),
                          onPressed: () {
                            ShopCubit.get(context)
                                .changeFavorites(model.product.id);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
