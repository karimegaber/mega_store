class CategoriesModel {
  late bool status;
  late DataModel data;

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = DataModel.fromJson(json['data']);
  }
}

class DataModel {
  late int currentPage;
  late List<CategoryModel> categories = [];

  DataModel.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    json['data'].forEach((element) {
      categories.add(CategoryModel.fromJson(element));
    });
  }
}

class CategoryModel {
  late int id;
  late String name;
  late String image;

  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}
