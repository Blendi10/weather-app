import '../../domain/entities/clouds_entity.dart';

class CloudsModel extends CloudsEntity {
  const CloudsModel({required super.coverage});

  factory CloudsModel.fromJson(Map<String, dynamic> json) {
    return CloudsModel(coverage: json['all'] as int);
  }
}
