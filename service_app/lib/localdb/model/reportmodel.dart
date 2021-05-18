import 'dart:io';

final String tableReports = 'reports';

class ReportsFields {
  static final List<String> values = [
    /// Add all fields
    id, name, incident, address, description, image,time
  ];

  static final String id = '_id';
  static final String name = 'name';
  static final String incident = 'incident';
  static final String address = 'address';
  static final String description = 'description';
  static final String image = 'image';
  static final String time = 'time';

}
class Reports {
  final int? id;
  final String name;
  final String incident;
  final String address;
  final String description;

  final DateTime createdTime;
  const Reports({
    this.id,
    required this.incident,
    required this.address,
    required this.name,
    required this.description,

    required this.createdTime,
  });

  Reports copy({
    int? id,
    String? name,
    String? incident,
    String? address,
    String? description,

    DateTime? createdTime,
  }) =>
      Reports(
        id: id ?? this.id,
        name: name ?? this.name,
        incident: incident ?? this.incident,
        address: address ?? this.address,
        description: description ?? this.description,
        createdTime: createdTime ?? this.createdTime,

      );

  static Reports fromJson(Map<String, Object?> json) => Reports(
    id: json[ReportsFields.id] as int?,

    name: json[ReportsFields.name] as String,
    incident: json[ReportsFields.incident] as String,
    address: json[ReportsFields.address] as String,
    description: json[ReportsFields.description] as String,
    createdTime: DateTime.parse(json[ReportsFields.time] as String),

  );

  Map<String, Object?> toJson() => {
    ReportsFields.id: id,
    ReportsFields.name: name,
    ReportsFields.address: address,
    ReportsFields.incident: incident,
    ReportsFields.description: description,
    ReportsFields.time: createdTime.toIso8601String(),
  };
}