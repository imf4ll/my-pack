class PackageModel {
  final String? name;
  final String? id;
  final int created = DateTime.now().millisecondsSinceEpoch;
  bool? delivered;
  String? description;
  String? lastUpdate;

  PackageModel({
    this.name,
    this.description,
    this.id,
    this.delivered,
    this.lastUpdate,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'description': description,
    'id': id,
    'delivered': delivered,
    'lastUpdate': lastUpdate,
    'created': created,
  };
}
