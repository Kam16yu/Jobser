import 'package:domain/models/company_local_model.dart';
import 'package:domain/models/job_local_model.dart';
import 'package:hive/hive.dart';
import 'package:remote/models/company_model.dart';
import 'package:remote/models/job_model.dart';

JobLocalModel remoteJobToLocal(JobRemoteModel job, Box<JobLocalModel> jobBox){
    int jobLocalID = 0;
    try {
      jobLocalID = jobBox.keys.last + 1;
    } on StateError {
      //nothing
    }

    return JobLocalModel(
        jobLocalID: jobLocalID,
        jobID: job.jobRemoteID,
        companyID: job.companyRemoteID,
        title: job.title,
        description: job.description,
        city: job.city);
}

CompanyLocalModel remoteCompanyToLocal(CompanyRemoteModel company, Box<CompanyLocalModel> companyBox){
  int companyLocalID = 0;
  try {
    companyLocalID = companyBox.keys.last + 1;
  } on StateError {
    //nothing
  }
  return CompanyLocalModel(
      companyLocalID: companyLocalID,
      companyID: company.companyRemoteID,
      name: company.name,
      description: company.description,
      industry: company.industry);
}