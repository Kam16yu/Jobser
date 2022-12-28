import 'package:domain/domain.dart';

class AppManagement{

  SourcesRepository repo;
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

  Future<void> addCompany(CompanyLocalModel company) async {
    int response = await repo.addCompany(company);
  }

  Future<void> addJob(JobLocalModel job) async {
    int response = await repo.addJob(job);
  }

  Future<void> deleteCompany(int localId, int remoteId) async {
    int response = await repo.deleteCompany(localId, remoteId);
  }

  Future<void> deleteJob(int localId, int remoteId) async {
    int response = await repo.deleteJob(localId, remoteId);
  }

  List<CompanyLocalModel> getSavedCompanies(){
    return repo.getSavedCompanies();
  }

  List<JobLocalModel> getSavedCompanyJobs(int remoteId){
    return repo.getSavedCompanyJobs(remoteId);
  }

  List<JobLocalModel> getSavedJobs(){
    return repo.getSavedJobs();
  }

  Future<bool> internetConnection () {
    return repo.internetCheck();
  }
}