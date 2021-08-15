import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/search_products_model.dart';
import 'package:shop_app/shared/components/components.dart';

class SearchScreen extends StatelessWidget {
  static const String searchScreenRoute = '/search';

  @override
  Widget build(BuildContext context) {
    GlobalKey formKey = GlobalKey<FormState>();
    var searchController = TextEditingController();

    return BlocConsumer<ShopCubit, ShopAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Form(
          key: formKey,
          child: Scaffold(
            appBar: AppBar(
              title: Text('Search'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  defaultFormField(
                      controller: searchController,
                      label: 'Search',
                      validate: (value) {
                        if (value!.isEmpty) {
                          return 'write a word to search..';
                        }
                        return null;
                      },
                      prefix: Icons.search,
                      type: TextInputType.text,
                      onSubmit: (value) {
                        ShopCubit.get(context).getSearchData(value);
                      }),
                  if (state is ShopSuccessGetSearchDataState)
                    Expanded(
                      child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        itemBuilder: (context, index) => buildSearchedItem(
                            ShopCubit.get(context)
                                .searchProductsModel!
                                .searchData
                                .productsData[index],
                            context),
                        separatorBuilder: (context, index) => SizedBox(
                          height: 10.0,
                        ),
                        itemCount: ShopCubit.get(context)
                            .searchProductsModel!
                            .searchData
                            .productsData
                            .length,
                      ),
                    ),
                  if (state is ShopLoadingGetSearchDataState)
                    CircularProgressIndicator(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildSearchedItem(Product model, context) => Container(
        height: 130.0,
        padding: EdgeInsets.all(10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Container(
                color: Colors.white,
                child: Image(
                  image: NetworkImage(model.image),
                  width: 140.0,
                  height: 120.0,
                ),
              ),
            ),
            SizedBox(
              width: 10.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name,
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
                            '${model.price} L.E',
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
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
