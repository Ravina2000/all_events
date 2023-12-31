class CategoryModel {
  String? category;
  String? data;
  bool isSelected = false; // check which category is selected

  CategoryModel({this.category, this.data, this.isSelected = false});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category'] = this.category;
    data['data'] = this.data;
    return data;
  }
}
