import 'package:domain/models/company_local_model.dart';
import 'package:domain/models/job_local_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remote/remote.dart';

void main() {
  final client = RestClient();
  int companyID = 0;
  int jobID = 0;

  JobLocalModel simpleJob = JobLocalModel(
      jobLocalID: 0,
      jobID: jobID,
      companyID: companyID,
      title: 'Junior Flutter developer',
      description: 'Mobile app developing',
      city: 'Lviv');

  CompanyLocalModel simpleCompany = CompanyLocalModel(
      companyLocalID: 0,
      companyID: companyID,
      name: 'Googie',
      description: 'Top IT company',
      industry: 'IT');

  test('Get jobs', () async {
    final list = await client.getJobs();
    expect(list.isNotEmpty, true);
  });

  test('Add company', () async {
    final result = await client.addCompany(simpleCompany);
    companyID = result;
    simpleJob.companyID = companyID;
    simpleCompany.companyID = companyID;
    expect(result != -1, true);
  });

  test('Get companies', () async {
    final list = await client.getCompanies();
    expect(list.isNotEmpty, true);
  });

  test('Add job to company', () async {
    final result = await client.addJob(simpleJob);
    jobID = result;
    simpleJob.jobID = jobID;
    expect(result != -1, true);
  });

  test('Get company jobs', () async {
    final list = await client.getCompanyJobs(companyID);
    expect(list.isNotEmpty, true);
  });

  test('Delete job', () async {
    final result = await client.deleteJob(jobID);
    expect(result != -1, true);
  });

  test('Delete company', () async {
    final result = await client.deleteCompany(companyID);
    expect(result != -1, true);
  });
}
