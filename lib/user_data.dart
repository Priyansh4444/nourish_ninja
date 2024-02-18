class FoodItem {
  final String? name;
  final String? description;
  final String? price;
  final String? image;

  FoodItem({this.name, this.description, this.price, this.image});
}


class UserData {
  double? balance;
  List<FoodItem>? foodItems;
  
}