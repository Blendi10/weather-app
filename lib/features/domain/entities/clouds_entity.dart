import 'package:equatable/equatable.dart';

class CloudsEntity extends Equatable {
  final int coverage;

  const CloudsEntity({required this.coverage});

  @override
  List<Object?> get props => [coverage];
}
