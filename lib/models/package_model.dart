import './update_model.dart';

class PackageModel {
  final String? name;
  final String? id;
  final String? description;
  final int? created;
  final List<UpdateModel>? updates;
  final bool? delivered;

  const PackageModel({
    this.name,
    this.id,
    this.description,
    this.created,
    this.updates,
    this.delivered
  });
}
