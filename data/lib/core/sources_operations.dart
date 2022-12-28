import 'package:data/core/constants.dart';
import 'package:data/local/company_model_hive_adapter.dart';
import 'package:data/local/job_model_hive_adapter.dart';
import 'package:data/mappers/models_mapper.dart';
import 'package:domain/models/company_local_model.dart';
import 'package:domain/models/job_local_model.dart';
import 'package:domain/repository/vacancies_repository.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:remote/models/company_model.dart';
import 'package:remote/models/job_model.dart';
import '../source/remote.dart';

Future<void> initDataLayer() async {
  await Hive.initFlutter();
  Hive.registerAdapter(CompanyLocalModelAdapter());
  Hive.registerAdapter(JobLocalModelAdapter());
  await Hive.openBox<CompanyLocalModel>(companyBoxName);
  await Hive.openBox<JobLocalModel>(jobBoxName);
}

class DbAndRemoteOperations implements VacanciesRepository {
  RemoteOperations client;
  Box<CompanyLocalModel> companyBox = Hive.box(companyBoxName);
  late Box<JobLocalModel> jobBox = Hive.box(jobBoxName);

  // Constructor with injector magic
  DbAndRemoteOperations(this.client);

  @override
  Future<List<JobLocalModel>> getJobs() async {
    List<JobLocalModel> jobList = [];
    final remoteJobs = await client.getJobs();
    if (remoteJobs.isNotEmpty) {
      await jobBox.clear();
      for (JobRemoteModel job in remoteJobs) {
        jobList.add(remoteJobToLocal(job, jobBox));

      }
      jobBox.addAll(jobList);
      return jobList;
    }
    return jobBox.values.toList();
  }

  @override
  Future<int> addCompany(CompanyLocalModel company) async {
    int companyLocalID = 0;
    try {
      companyLocalID = companyBox.keys.last + 1;
    } on StateError {
      //nothing
    }
    //request
    final result = await client.addCompany(company);
    //if is in DB and only local
    if (company.companyID == -1) {
      //if request failed
      if (result == -1) {
        return -1;
      }
      companyBox.delete(company.companyLocalID);
      company.companyID = result;
      company.companyLocalID = companyLocalID;
      companyBox.add(company);
      return result;
    }

    company.companyLocalID = companyLocalID;
    if (result != -1) {
      //if is remote
      company.companyID = result;
    } else {
      //if is only local
      company.companyID = -1;
    }
    companyBox.add(company);

    return result;
  }

  @override
  Future<List<CompanyLocalModel>> getCompanies() async {
    List<CompanyLocalModel> companyList = [];
    final remoteCompanies = await client.getCompanies();
    if (remoteCompanies.isNotEmpty) {
      await companyBox.clear();
      for (CompanyRemoteModel company in remoteCompanies) {
        companyList.add(remoteCompanyToLocal(company, companyBox));
      }
      companyBox.addAll(companyList);
      return companyList;
    }

    return companyBox.values.toList();
  }

  @override
  Future<int> addJob(JobLocalModel job) async {
    int jobLocalID = 0;
    try {
      jobLocalID = jobBox.keys.last + 1;
    } on StateError {
      //nothing
    }
    //request
    final result = await client.addJob(job);
    //if is in DB and only local
    if (job.jobID == -1) {
      //if request failed
      if (result == -1) {
        return -1;
      }
      jobBox.delete(job.jobLocalID);
      job.jobLocalID = jobLocalID;
      jobBox.add(job);
      return result;
    }

    job.jobLocalID = jobLocalID;
    if (result != -1) {
      //if is remote
      job.jobID = result;
    } else {
      //if is only local
      job.jobID = -1;
    }
    jobBox.add(job);

    return result;
  }

  @override
  Future<List<JobLocalModel>> getCompanyJobs(int companyRemoteID) async {
    final jobList = await client.getCompanyJobs(companyRemoteID);
    List<JobLocalModel> localList = [];
    if (jobList.isNotEmpty) {
      for (var job in jobList) {
        localList.add(remoteJobToLocal(job, jobBox));
      }

      return localList;
    }

    return jobBox.values.where((e) => e.companyID == companyRemoteID).toList();
  }

  @override
  Future<int> deleteJob(int localId, int remoteId) async {
    //If only local record
    if (remoteId == -1) {
      jobBox.delete(localId);

      return 200;
    }
    //request
    final result = await client.deleteJob(remoteId);
    //If remote deleted
    if (result != -1) {
      jobBox.delete(localId);
    }

    return result;
  }

  @override
  Future<int> deleteCompany(int localId, int remoteId) async {
    //If only local record
    if (remoteId == -1) {
      companyBox.delete(localId);

      return 200;
    }
    //request
    final result = await client.deleteCompany(remoteId);
    //If remote deleted
    if (result != -1) {
      companyBox.delete(localId);
    }

    return result;
  }
}
