import 'package:domain/domain.dart';

class AppManagement{

  VacanciesRepository repo;
  // Constructor with injector magic
  AppManagement(this.repo);

  Future<List<CompanyLocalModel>>getCompanies() async {
    List<CompanyLocalModel> response = await repo.getCompanies();
    return response;
  }

  Future<List<JobLocalModel>>getCompanyJobs(int remoteId) async {
    List<JobLocalModel> response = await repo.getCompanyJobs(remoteId);
    return response;
  }

  Future<List<JobLocalModel>> getJobs() async {
    List<JobLocalModel> response = await repo.getJobs();
    return response;
  }

  addCompany(String request, CompanyLocalModel company) async {
    int response = await repo.addCompany(company);
  }

  addJob(JobLocalModel job) async {
    int response = await repo.addJob(job);
  }

  deleteCompany(int localId, int remoteId) async {
    int response = await repo.deleteCompany(localId, remoteId);
  }

  deleteJob(int localId, int remoteId) async {
    int response = await repo.deleteJob(localId, remoteId);
  }

}