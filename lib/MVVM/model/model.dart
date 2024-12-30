class Model {
  String? title;
  String? description;
  String? id;

  Model({
    this.title,
    this.description,
    this.id
  });

  Model.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    id = json['_id'];
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      '_id':id,
    };
  }
}
