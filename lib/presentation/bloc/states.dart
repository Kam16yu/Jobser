import 'package:domain/entities/company_model.dart';
import 'package:domain/entities/job_model.dart';

abstract class ListState {}

class ListInitState extends ListState {}

class UpdateJobState implements ListState {
  final List<JobModel> jobs;

  UpdateJobState(this.jobs);
}

class UpdateCompanyState implements ListState {
  final List<CompanyModel> companies;

  UpdateCompanyState(this.companies);
}
