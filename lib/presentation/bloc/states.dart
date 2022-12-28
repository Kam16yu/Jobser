import 'package:domain/models/company_local_model.dart';
import 'package:domain/models/job_local_model.dart';

abstract class ListState {}

class ListInitState extends ListState {}

class UpdateJobsCompaniesState implements ListState {
  final List<JobLocalModel> jobs;
  final List<CompanyLocalModel> companies;
  UpdateJobsCompaniesState(this.jobs, this.companies);
}

class UpdateCompaniesState implements ListState {
  final List<CompanyLocalModel> companies;

  UpdateCompaniesState(this.companies);
}

class UpdateCompaniesJobState implements ListState {
  final List<JobLocalModel> jobs;

  UpdateCompaniesJobState(this.jobs);
}
