class CompanyLocalModel {
  int companyLocalID;
  int companyID;
  String name;
  String description;
  String industry;

  CompanyLocalModel({
    required this.companyLocalID,
    required this.companyID,
    required this.name,
    required this.description,
    required this.industry,
  });

  //Constructor from map
  CompanyLocalModel.fromMap(Map<String, dynamic> map)
      : companyLocalID = map ['companyLocalID'] as int,
        companyID = map["companyID"] as int,
        name = map["name"] as String,
        description = map["description"] as String,
        industry = map["industry"] as String;

  Map<String, dynamic> toMap() => {
    "companyLocalID": companyLocalID,
    "companyID": companyID,
    "name": name,
    "description": description,
    "industry": industry,
  };
}
