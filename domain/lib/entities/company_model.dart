//DataModel class with Hive datatype adapter annotations
class CompanyModel {
  final int? companyID;
  final String? name;
  final String? description;
  final String? industry;

  CompanyModel({
    required this.companyID,
    required this.name,
    required this.description,
    required this.industry,
  });

  //Constructor from map
  CompanyModel.fromMap(Map<String, dynamic> map)
      : companyID = map["id"] as int?,
        name = map["name"] as String?,
        description = map["description"] as String?,
        industry = map["industry"] as String?;

  Map<String, dynamic> toMap() => {
    "id": companyID,
    "name": name,
    "description": description,
    "industry": industry,
  };
}
