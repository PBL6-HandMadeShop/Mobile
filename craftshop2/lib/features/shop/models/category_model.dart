class CategoryModel{
  String id;
  String name;
  String image;
  String parentId;
  bool isFeatured;
  CategoryModel({
    required this.id,
    required this.name,
    required this.image,
    this.parentId ='',
    this.isFeatured = false,
  });

  static CategoryModel empty() => CategoryModel(id: '', name: '', image: '', parentId: '', isFeatured: false);

  Map<String, dynamic> toFormData() => {
    'id': id,
    'name': name,
    'image': image,
    'parentId': parentId,
    'isFeatured': isFeatured,
  };
}