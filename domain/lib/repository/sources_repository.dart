import 'package:domain/models/company_local_model.dart';
import 'package:domain/models/job_local_model.dart';

abstract class SourcesRepository {
  Future<List<JobLocalModel>> getJobs();

  Future<int> addCompany(CompanyLocalModel company);

  Future<List<CompanyLocalModel>> getCompanies();

  Future<List<JobLocalModel>> getCompanyJobs(int remoteId);

  Future<int> addJob(JobLocalModel job);

  Future<int> deleteJob(int localId, int remoteId);

  Future<int> deleteCompany(int localId, int remoteId);

  List<CompanyLocalModel> getSavedCompanies();

  List<JobLocalModel> getSavedCompanyJobs(int remoteId);

  List<JobLocalModel> getSavedJobs();

  Future<bool> internetCheck();
}
