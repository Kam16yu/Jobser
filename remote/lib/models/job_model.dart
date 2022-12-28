class JobRemoteModel {
  int jobRemoteID;
  int companyRemoteID;
  String title;
  String description;
  String city;

  JobRemoteModel({
    required this.jobRemoteID,
    required this.companyRemoteID,
    required this.title,
    required this.description,
    required this.city,
  });

  //Constructor from map
  JobRemoteModel.fromMap(Map<String, dynamic> map)
      : jobRemoteID = map["id"] as int,
        companyRemoteID = map["companyId"] as int,
        title = map["title"] as String,
        description = map["description"] as String,
        city = map["city"] as String;

  Map<String, dynamic> toMap() => {
        "id": jobRemoteID,
        "companyId": companyRemoteID,
        "title": title,
        "description": description,
        "city": city,
      };

  @override
  String toString() {
    return 'Job: id: $jobRemoteID, company: $companyRemoteID, title: $title, description: '
        '$description, city: $city';
  }
}
