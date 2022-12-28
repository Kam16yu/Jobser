class JobLocalModel {
  int jobLocalID;
  int jobID;
  int companyID;
  String title;
  String description;
  String city;

  JobLocalModel({
    required this.jobLocalID,
    required this.jobID,
    required this.companyID,
    required this.title,
    required this.description,
    required this.city,
  });

  //Constructor from map
  JobLocalModel.fromMap(Map<String, dynamic> map)
      : jobLocalID = map["jobLocalID"] as int,
        jobID = map["jobID"] as int,
        companyID = map["companyID"] as int,
        title = map["title"] as String,
        description = map["description"] as String,
        city = map["city"] as String;

  Map<String, dynamic> toMap() => {
        "jobLocalID": jobLocalID,
        "jobID": jobID,
        "companyID": companyID,
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
