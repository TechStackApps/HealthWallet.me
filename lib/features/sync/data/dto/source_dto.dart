/// Data Transfer Object for API source response
class SourceDto {
  final String id;
  final String? name;
  final String? logo;
  final String? labelSource;
  final String? createdAt;
  final String? updatedAt;
  final String? platformType;
  final String? display;

  const SourceDto({
    required this.id,
    this.name,
    this.logo,
    this.labelSource,
    this.createdAt,
    this.updatedAt,
    this.platformType,
    this.display,
  });

  factory SourceDto.fromJson(Map<String, dynamic> json) {
    return SourceDto(
      id: json['id'] ?? '',
      name: json['name'],
      logo: json['logo'],
      labelSource: json['labelSource'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      platformType: json['platform_type'],
      display: json['display'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'logo': logo,
      'labelSource': labelSource,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'platform_type': platformType,
      'display': display,
    };
  }
}
