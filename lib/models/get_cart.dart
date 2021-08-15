class GetCart {
  late bool status;
  CartDetails? cartDetails;

  GetCart.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    cartDetails = CartDetails.fromJson(json['data']);
  }
}

class CartDetails {
  late List<ProductInCart> products = [];
  late dynamic subTotal;
  late dynamic total;
  CartDetails.fromJson(Map<String, dynamic> json) {
    json['cart_items'].forEach((element) {
      products.add(ProductInCart.fromJson(element));
    });
    subTotal = json['sub_total'];
    total = json['total'];
  }
}

class ProductInCart {
  late int inCartID;
  late int quantity;
  Product? product;

  ProductInCart.fromJson(Map<String, dynamic> json) {
    inCartID = json['id'];
    quantity = json['quantity'];
    product = Product.fromJson(json['product']);
  }
}

class Product {
  late int id;
  late dynamic price;
  late String image;
  late String name;

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    image = json['image'];
    name = json['name'];
  }
}
