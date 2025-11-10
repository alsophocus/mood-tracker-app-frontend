class TagModel {
  final int? id;
  final String name;
  final String category;
  final String color;
  final String icon;
  final String? createdAt;

  TagModel({
    this.id,
    required this.name,
    required this.category,
    this.color = '#808080',
    this.icon = 'tag',
    this.createdAt,
  });

  factory TagModel.fromJson(Map<String, dynamic> json) {
    return TagModel(
      id: json['id'],
      name: json['name'],
      category: json['category'],
      color: json['color'] ?? '#808080',
      icon: json['icon'] ?? 'tag',
      createdAt: json['created_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'category': category,
      'color': color,
      'icon': icon,
      if (createdAt != null) 'created_at': createdAt,
    };
  }
}

class TagCategoriesResponse {
  final Map<String, List<TagModel>> categories;

  TagCategoriesResponse({required this.categories});

  factory TagCategoriesResponse.fromJson(Map<String, dynamic> json) {
    final Map<String, List<TagModel>> categoriesMap = {};

    json.forEach((key, value) {
      if (value is List) {
        categoriesMap[key] = value.map((tag) => TagModel.fromJson(tag)).toList();
      }
    });

    return TagCategoriesResponse(categories: categoriesMap);
  }
}
