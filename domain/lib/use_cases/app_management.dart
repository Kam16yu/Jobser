import 'package:domain/domain.dart';

class AppManagement {
  SourcesRepository repo;

  // Constructor with injector magic
  AppManagement(this.repo);

  Future<List<CompanyLocalModel>> getCompanies() async {
    List<CompanyLocalModel> response = await repo.getCompanies();

    return response;
  }

  Future<List<JobLocalModel>> getCompanyJobs(int remoteId) async {
    List<JobLocalModel> response = await repo.getCompanyJobs(remoteId);

    return response;
  }

  Future<List<JobLocalModel>> getJobs() async {
    List<JobLocalModel> response = await repo.getJobs();

    return response;
  }

  Future<int> addCompany(CompanyLocalModel company) async {
    return await repo.addCompany(company);
  }

  Future<int> addJob(JobLocalModel job) async {
    return await repo.addJob(job);
  }

  Future<int> deleteCompany(int localId, int remoteId) async {
    return await repo.deleteCompany(localId, remoteId);
  }

  Future<int> deleteJob(int localId, int remoteId) async {
    return await repo.deleteJob(localId, remoteId);
  }

  List<CompanyLocalModel> getSavedCompanies() {
    return repo.getSavedCompanies();
  }

  List<JobLocalModel> getSavedCompanyJobs(int remoteId) {
    return repo.getSavedCompanyJobs(remoteId);
  }

  List<JobLocalModel> getSavedJobs() {
    return repo.getSavedJobs();
  }

  Future<bool> internetConnection() {
    return repo.internetCheck();
  }
}
