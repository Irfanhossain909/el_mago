class RetailerModel {
  final String id;
  final String name;

  RetailerModel({required this.id, required this.name});

  factory RetailerModel.fromJson(Map<String, dynamic> json) =>
      RetailerModel(id: json["_id"], name: json["name"]);
}
