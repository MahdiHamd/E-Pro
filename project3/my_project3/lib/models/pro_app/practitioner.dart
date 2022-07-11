class Practitioner {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? status;
  int? experience;
  String? evaluation;
  int? categoriesId;
  String? picture;
  String? description;
  bool? isFavorite;

  Practitioner.def() {}

  Practitioner({
    this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.picture,
    this.categoriesId,
    required this.description,
    required this.evaluation,
    required this.experience,
    required this.status,
    this.isFavorite,
  });

  Practitioner.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    status = json['status'];
    experience = json['exp'];
    evaluation = json['evaluation'];
    categoriesId = json['section'];
    picture = json['image'];
    description = json['des'];
    isFavorite = json['isFavorite'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'status': status,
      'exp': experience,
      'evaluation': evaluation,
      'section': categoriesId,
      "image": picture,
      "isFavorite":isFavorite
    };
  }
}
