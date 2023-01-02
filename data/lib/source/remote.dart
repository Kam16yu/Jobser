import 'package:domain/models/company_local_model.dart';
import 'package:domain/models/job_local_model.dart';
import 'package:remote/models/company_model.dart';
import 'package:remote/models/job_model.dart';

abstract class RemoteOperations {
  Future<List<JobRemoteModel>> getJobs({String request}); //List<JobModel>>

  Future<int> addJob(JobLocalModel job, {String request});

  Future<int> deleteJob(int id, {String request});

  Future<List<CompanyRemoteModel>> getCompanies(
      {String request}); //List<CompanyModel>

  Future<int> addCompany(CompanyLocalModel company, {String request});

  Future<List<JobRemoteModel>> getCompanyJobs(int id,
      {String request}); //List<JobModel>>

  Future<int> deleteCompany(int id, {String request});
}
