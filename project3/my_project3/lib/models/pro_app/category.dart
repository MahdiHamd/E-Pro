class MyCategories {
  int? id;
  String? name;
  String? image;

  MyCategories(Map<String, dynamic> data, {
    this.id,
    this.name,
    this.image,
  });

  MyCategories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['title'];
    image = json['image'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': name,
      'image': image,
    };
  }
}
