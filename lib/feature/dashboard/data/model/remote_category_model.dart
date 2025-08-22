class CategoryModel {
  final int CategoryId;
  final String categoryName;

  CategoryModel({
    required this.CategoryId,
    required this.categoryName,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
        CategoryId: json['id'], categoryName: json['category_name']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': CategoryId,
      'category_name': categoryName,
    };
  }
}
