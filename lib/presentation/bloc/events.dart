import 'package:domain/entities/company_model.dart';
import 'package:domain/entities/job_model.dart';

abstract class ListEvent {}

class ListInitEvent extends ListEvent {}

class GetJobsEvent extends ListEvent {
  GetJobsEvent();
}

class PostJobEvent extends ListEvent {
  final JobModel job;

  PostJobEvent(this.job);
}

class GetCompaniesEvent extends ListEvent {
}

class PostCompaniesEvent extends ListEvent {
  final CompanyModel company;
  PostCompaniesEvent(this.company);
}

class GetCompaniesJobsEvent extends ListEvent {
  GetCompaniesJobsEvent();
}
