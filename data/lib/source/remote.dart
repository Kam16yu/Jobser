import 'package:domain/entities/company_model.dart';
import 'package:domain/entities/job_model.dart';

abstract class RemoteRepository {
  Future<List<JobModel>> getJobs(String request);

  Future<String> addJob(String request, JobModel job);

  Future<String> deleteJob(String request, int id);

  Future<List<CompanyModel>> getCompanies(String request);

  Future<String> addCompany(String request, CompanyModel company);

  Future<List<JobModel>> getCompanyJobs(String request, int id);

  Future<String> deleteCompany(String request, int id);

}
