import 'package:data/source/remote.dart';
import 'package:domain/domain.dart';
import 'package:dio/dio.dart';
import 'package:remote/mapper/response_mapper.dart';

class RestClient implements RemoteRepository {

  final Dio dioInstance;

  RestClient({required this.dioInstance});

  @override
  Future<List<JobModel>> getJobs(String request) async {
    var response = await dioInstance.get(request);
    if (response.statusCode == 200) {
      List<JobModel> jobs = RemoteResponse.jobsFromJson(response.data);
      return jobs;
    }
    return [];
  }

  @override
  Future<String> addJob(String request, JobModel job) {
    // TODO: implement addJob
    throw UnimplementedError();
  }

  @override
  Future<String> deleteJob(String request, int id) {
    // TODO: implement deleteJob
    throw UnimplementedError();
  }

  @override
  Future<List<CompanyModel>> getCompanies(String request) {
    // TODO: implement getCompanies
    throw UnimplementedError();
  }

  @override
  Future<String> addCompany(String request, CompanyModel company) {
    // TODO: implement addCompany
    throw UnimplementedError();
  }

  @override
  Future<List<JobModel>> getCompanyJobs(String request, int id) {
    // TODO: implement getCompanyJobs
    throw UnimplementedError();
  }

  @override
  Future<String> deleteCompany(String request, int id) {
    // TODO: implement deleteCompany
    throw UnimplementedError();
  }
}
