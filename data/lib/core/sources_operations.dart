import 'package:data/core/constants.dart';
import 'package:data/local/company_model_hive_adapter.dart';
import 'package:data/local/job_model_hive_adapter.dart';
import 'package:data/mappers/models_mapper.dart';
import 'package:domain/models/company_local_model.dart';
import 'package:domain/models/job_local_model.dart';
import 'package:domain/repository/sources_repository.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:remote/models/company_model.dart';
import 'package:remote/models/job_model.dart';

import '../sensors/internet_status_check.dart';
import '../source/remote.dart';

Future<void> initDataLayer() async {
  await Hive.initFlutter();
  Hive.registerAdapter(CompanyLocalModelAdapter());
  Hive.registerAdapter(JobLocalModelAdapter());
  await Hive.openBox<CompanyLocalModel>(companyBoxName);
  await Hive.openBox<JobLocalModel>(jobBoxName);
}

class DbAndRemoteOperations implements SourcesRepository {
  RemoteOperations client;
  Box<CompanyLocalModel> companiesBox = Hive.box(companyBoxName);
  late Box<JobLocalModel> jobBox = Hive.box(jobBoxName);

  // Constructor with injector magic
  DbAndRemoteOperations(this.client);

  ///Get Jobs,List<JobLocalModel> - ok, [] - failed
  @override
  Future<List<JobLocalModel>> getJobs() async {
    List<JobLocalModel> jobList = [];
    //Get Jobs, from remote layer,List<JobRemoteModel> - ok, [] - failed
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

  ///Add company,int id 1..2..  - ok, -1 - failed
  @override
  Future<int> addCompany(CompanyLocalModel company) async {
    // -1 - failed
    int companyLocalID = 0;
    try {
      companyLocalID = companiesBox.keys.last + 1;
    } on StateError {
      //nothing
    }
    //Add company, to remote layer, int id 1..2..  - ok, -1 - failed
    final result = await client.addCompany(company);
    //if company is in DB and only local
    if (company.companyID == -1) {
      //if request failed
      if (result == -1) {
        return -1;
      }
      // Update company remote status
      companiesBox.delete(company.companyLocalID);
      company.companyID = result;
      company.companyLocalID = companyLocalID;
      companiesBox.add(company);

      return result;
    }
    //Set unique local ID for Hive box, unique remote ID from server response
    company.companyLocalID = companyLocalID;
    if (result != -1) {
      //if is remote
      company.companyID = result;
    } else {
      //if is only local
      company.companyID = -1;
    }
    companiesBox.add(company);

    return result;
  }

  ///Get Companies, List<CompanyLocalModel> - ok, [] - failed
  @override
  Future<List<CompanyLocalModel>> getCompanies() async {
    List<CompanyLocalModel> companyList = [];
    //Get Companies, from remote layer, List<CompanyRemoteModel> - ok, [] - failed
    final remoteCompanies = await client.getCompanies();
    if (remoteCompanies.isNotEmpty) {
      await companiesBox.clear();
      for (CompanyRemoteModel company in remoteCompanies) {
        companyList.add(remoteCompanyToLocal(company, companiesBox));
      }
      companiesBox.addAll(companyList);

      return companyList;
    }

    return companiesBox.values.toList();
  }

  ///Add job,int id 1..2..  - ok, -1 - failed
  @override
  Future<int> addJob(JobLocalModel job) async {
    int jobLocalID = 0;
    try {
      jobLocalID = jobBox.keys.last + 1;
    } on StateError {
      //nothing
    }
    //Add job, to remote layer,int id 1..2..  - ok, -1 - failed
    final result = await client.addJob(job);
    //if job is in DB and only local
    if (job.jobID == -1) {
      //if request failed
      if (result == -1) {
        return -1;
      }
      // Update Job remote status
      jobBox.delete(job.jobLocalID);
      job.jobLocalID = jobLocalID;
      jobBox.add(job);

      return result;
    }
    //Set unique local ID for Hive box, unique remote ID from server response
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

  ///Get Company jobs,List<JobLocalModel> - ok, [] - failed
  @override
  Future<List<JobLocalModel>> getCompanyJobs(int companyRemoteID) async {
    //Get Company jobs, from remote layer, List<JobRemoteModel> - ok, [] - failed
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

  ///Delete job,int id 1..2..  - ok, -1 - failed
  @override
  Future<int> deleteJob(int localId, int remoteId) async {
    //If only local record
    if (remoteId == -1) {
      jobBox.delete(localId);

      return 200;
    }
    //Delete job, from remote layer int id 1..2..  - ok, -1 - failed
    final result = await client.deleteJob(remoteId);
    //If remote deleted
    if (result != -1) {
      jobBox.delete(localId);
    }

    return result;
  }

  ///Delete company, from remote layer int id 1..2..  - ok, -1 - failed
  @override
  Future<int> deleteCompany(int localId, int remoteId) async {
    //If only local record
    if (remoteId == -1) {
      companiesBox.delete(localId);

      return 100;
    }
    //Delete company, from remote layer int id 1..2..  - ok, -1 - failed
    final result = await client.deleteCompany(remoteId);
    //If remote deleted
    if (result != -1) {
      companiesBox.delete(localId);
    }

    return result;
  }

  /// Get companies from local DB
  @override
  List<CompanyLocalModel> getSavedCompanies() {
    return companiesBox.values.toList();
  }

  /// Get company jobs from local DB
  @override
  List<JobLocalModel> getSavedCompanyJobs(int remoteId) {
    return jobBox.values.where((e) => e.companyID == remoteId).toList();
  }

  /// Get jobs from local DB
  @override
  List<JobLocalModel> getSavedJobs() {
    return jobBox.values.toList();
  }

  ///Test internet connection
  @override
  Future<bool> internetCheck() {
    return internetStatusCheck();
  }
}
