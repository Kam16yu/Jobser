//DataModel class with Hive datatype adapter annotations
class CompanyRemoteModel {
  int companyRemoteID;
  String name;
  String description;
  String industry;

  CompanyRemoteModel({
    required this.companyRemoteID,
    required this.name,
    required this.description,
    required this.industry,
  });

  //Constructor from map
  CompanyRemoteModel.fromMap(Map<String, dynamic> map)
      : companyRemoteID = map["id"] as int,
        name = map["name"] as String,
        description = map["description"] as String,
        industry = map["industry"] as String;

  Map<String, dynamic> toMap() => {
    "companyID": companyRemoteID,
    "name": name,
    "description": description,
    "industry": industry,
  };
}
