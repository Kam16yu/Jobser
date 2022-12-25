import 'package:domain/domain.dart';

class RemoteResponse {

  RemoteResponse();

  static List<JobModel> jobsFromJson(Map<String, dynamic> json) {
    final List<JobModel> jobsData = [];
    if (json['result'] != null) {
      json['result'].forEach((mapInList) {
        jobsData.add(JobModel.fromMap(mapInList));
      });
    }
    return jobsData;
  }

  static Map<String, dynamic> jobToJson(JobModel job) {
    final Map<String, dynamic> jobMap = <String, dynamic>{};
    jobMap['result'] = job.toMap().remove('id');
    return jobMap;
  }
}