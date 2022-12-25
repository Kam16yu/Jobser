import 'package:domain/entities/company_model.dart';
import 'package:domain/entities/job_model.dart';

abstract class LocalRepository {
  Future<List<JobModel>> getJobs();

  Future<String> addJob(JobModel job);

  Future<List<CompanyModel>> getCompanies();

  Future<String> addCompany(CompanyModel company);

  Future<List<JobModel>> getCompanyJobs(int id);
}
