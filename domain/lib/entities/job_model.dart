//JobModel class with Hive datatype adapter annotations
class JobModel {
  final int? jobID;
  final int? companyID;
  final String? title;
  final String? description;
  final String? city;

  JobModel({
    required this.jobID,
    required this.companyID,
    required this.title,
    required this.description,
    required this.city,
  });

  //Constructor from map
  JobModel.fromMap(Map<String, dynamic> map)
      : jobID = map["id"] as int?,
        companyID = map["companyId"] as int?,
        title = map["title"] as String?,
        description = map["description"] as String?,
        city = map["city"] as String?;

  Map<String, dynamic> toMap() => {
        "id": jobID,
        "companyId": companyID,
        "title": title,
        "description": description,
        "city": city,
      };

  @override
  String toString() {
    return 'Job: id: $jobID, company: $companyID, title: $title, description: '
        '$description, city: $city';
  }
}
