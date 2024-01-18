import 'package:centinelas_app/domain/entities/unique_id.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserSessionModel extends Equatable {
  final String email;
  final String? displayName;

  const UserSessionModel(
    this.displayName,
    {
      required this.email,
    }
  );

  factory UserSessionModel.fromJson(
    Map<String, dynamic> json
  ) => _$UserSessionModelFromJson(json);

  Map<String, dynamic> toJson() =>
      _$UserSessionModelToJson(this);

  @override
  List<Object?> get props => [email, displayName];
}