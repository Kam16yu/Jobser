import 'package:data/core/constants.dart';
import 'package:data/source/remote.dart';
import 'package:dio/dio.dart';
import 'package:domain/models/company_local_model.dart';
import 'package:domain/models/job_local_model.dart';
import 'package:flutter/foundation.dart';
import 'package:remote/mapper/response_mapper.dart';
import 'package:remote/models/company_model.dart';
import 'package:remote/models/job_model.dart';

class RestClient implements RemoteOperations {
  final Dio dioInstance = Dio()
    ..interceptors.add(LogInterceptor(
      responseHeader: false,
      responseBody: true,
    ));

  // Constructor with injector magic
  RestClient();

  @override
  Future<List<JobRemoteModel>> getJobs({String request = jobsEndpoint}) async {
    try {
      var response = await dioInstance.get(request);
      if (response.statusCode == 200) {
        List<JobRemoteModel> jobs = ResponseMapper.jobsFromJson(response.data);

        return jobs;
      }
    } on DioError catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }

    return [];
  }

  @override
  Future<int> addJob(JobLocalModel job, {String request = jobsEndpoint}) async {
    try {
      var response =
          await dioInstance.post(request, data: ResponseMapper.jobToJson(job));
      if (response.statusCode == 200) {
        int jobId = ResponseMapper.idFromJson(response.data);

        return jobId;
      }
    } on DioError catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }

    return -1;
  }

  @override
  Future<int> deleteJob(int id, {String request = deleteJobEndpoint}) async {
    try {
      var response = await dioInstance.delete(
          request.replaceFirst('{id}', '$id'),
          options: Options(headers: {'content-type': 'text/plain'}));

      return response.statusCode ?? 200;
    } on DioError catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }

    return -1;
  }

  @override
  Future<List<CompanyRemoteModel>> getCompanies(
      {String request = companiesEndpoint}) async {
    try {
      var response = await dioInstance.get(request);
      if (response.statusCode == 200) {
        List<CompanyRemoteModel> company =
            ResponseMapper.companiesFromJson(response.data);

        return company;
      }
    } on DioError catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }

    return [];
  }

  @override
  Future<int> addCompany(CompanyLocalModel company,
      {String request = companiesEndpoint}) async {
    try {
      var response = await dioInstance.post(request,
          data: ResponseMapper.companyToJson(company));
      if (response.statusCode == 200) {
        int companyId = ResponseMapper.idFromJson(response.data);

        return companyId;
      }
    } on DioError catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }

    return -1;
  }

  @override
  Future<List<JobRemoteModel>> getCompanyJobs(int id,
      {String request = companyJobsEndpoint}) async {
    try {
      var response =
          await dioInstance.get(request.replaceFirst('{id}', id.toString()));
      if (response.statusCode == 200) {
        List<JobRemoteModel> jobs = ResponseMapper.jobsFromJson(response.data);

        return jobs;
      }
    } on DioError catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }

    return [];
  }

  @override
  Future<int> deleteCompany(int id,
      {String request = deleteCompanyEndpoint}) async {
    try {
      var response = await dioInstance.delete(
          request.replaceFirst('{id}', '$id'),
          options: Options(headers: {'content-type': 'text/plain'}));
      return response.statusCode ?? 200;
    } on DioError catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }

    return -1;
  }
}
