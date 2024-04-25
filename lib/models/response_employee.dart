import 'package:meta/meta.dart';
import 'dart:convert';

ResponseEmployee responseEmployeeFromJson(String str) => ResponseEmployee.fromJson(json.decode(str));

String responseEmployeeToJson(ResponseEmployee data) => json.encode(data.toJson());

class ResponseEmployee {
  ResponseEmployee({
    required this.id,
    required this.nip,
    required this.name,
    required this.email,
    required this.phone,
    required this.teamId,
    required this.image,
    required this.hash,
    required this.roles,
    required this.teams,
  });

  int id;
  String nip;
  String name;
  String email;
  String phone;
  String teamId;
  String image;
  String hash;
  List<Role> roles;
  Teams teams;

  factory ResponseEmployee.fromJson(Map<String, dynamic> json) => ResponseEmployee(
    id: json["id"],
    nip: json["nip"],
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    teamId: json["team_id"],
    image: json["image"],
    hash: json["hash"],
    roles: List<Role>.from(json["roles"].map((x) => Role.fromJson(x))),
    teams: Teams.fromJson(json["teams"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nip": nip,
    "name": name,
    "email": email,
    "phone": phone,
    "team_id": teamId,
    "image": image,
    "hash": hash,
    "roles": List<dynamic>.from(roles.map((x) => x.toJson())),
    "teams": teams.toJson(),
  };
}

class Role {
  Role({
    required this.id,
    required this.name,
    required this.guardName,
    required this.createdAt,
    required this.updatedAt,
    required this.pivot,
  });

  int id;
  String name;
  String guardName;
  DateTime createdAt;
  DateTime updatedAt;
  Pivot pivot;

  factory Role.fromJson(Map<String, dynamic> json) => Role(
    id: json["id"],
    name: json["name"],
    guardName: json["guard_name"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    pivot: Pivot.fromJson(json["pivot"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "guard_name": guardName,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "pivot": pivot.toJson(),
  };
}

class Pivot {
  Pivot({
    required this.modelId,
    required this.roleId,
    required this.modelType,
  });

  String modelId;
  String roleId;
  String modelType;

  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
    modelId: json["model_id"],
    roleId: json["role_id"],
    modelType: json["model_type"],
  );

  Map<String, dynamic> toJson() => {
    "model_id": modelId,
    "role_id": roleId,
    "model_type": modelType,
  };
}

class Teams {
  Teams({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String name;
  DateTime createdAt;
  DateTime updatedAt;

  factory Teams.fromJson(Map<String, dynamic> json) => Teams(
    id: json["id"],
    name: json["name"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
