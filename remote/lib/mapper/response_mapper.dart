import 'package:domain/models/company_local_model.dart';
import 'package:domain/models/job_local_model.dart';
import 'package:remote/models/company_model.dart';
import 'package:remote/models/job_model.dart';

class ResponseMapper {

  static List<JobRemoteModel> jobsFromJson(Map<String, dynamic> json) {
    final List<JobRemoteModel> jobsData = [];
    if (json['result'] != null) {
      json['result'].forEach((mapInList) {
        Map<String, dynamic> map = mapInList;
        if (map['title'] == null) {
          map['title'] = '';
        }
        if (map['description'] == null) {
          map['description'] = '';
        }
        if (map['city'] == null) {
          map['city'] = '';
        }
        jobsData.add(JobRemoteModel.fromMap(map));
      });
    }
    return jobsData;
  }

  static Map<String, dynamic> jobToJson(JobLocalModel job) {
    final Map<String, dynamic> jobJson = {'title': job.title};
    jobJson['description'] = job.description;
    jobJson['city'] = job.city;
    jobJson['companyId'] = job.companyID;
    return jobJson;
  }

  static List<CompanyRemoteModel> companiesFromJson(Map<String, dynamic> json) {
    final List<CompanyRemoteModel> companiesData = [];
    if (json['result'] != null) {
      json['result'].forEach((mapInList) {
        Map<String, dynamic> map = mapInList;
        if (map['name'] == null) {
          map['name'] = '';
        }
        if (map['description'] == null) {
          map['description'] = '';
        }
        if (map['industry'] == null) {
          map['industry'] = '';
        }
        companiesData.add(CompanyRemoteModel.fromMap(map));
      });
    }
    return companiesData;
  }

  static Map<String, dynamic> companyToJson(CompanyLocalModel company) {
    final Map<String, dynamic> companyJson = {'name' : company.name};
    companyJson['description'] = company.description;
    companyJson['industry'] = company.industry;
    return companyJson;
  }

  static int idFromJson(Map<String, dynamic> json) {
    int id = 0;
    if (json['id'] != null) {
      id = json['id'];
    }
    return id;
  }
}