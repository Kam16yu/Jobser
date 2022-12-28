import 'package:domain/models/company_local_model.dart';
import 'package:domain/models/job_local_model.dart';

abstract class ListEvent {}

class ListInitEvent extends ListEvent {}

class GetJobsCompaniesEvent extends ListEvent {
  GetJobsCompaniesEvent();
}

class AddJobEvent extends ListEvent {
  final JobLocalModel job;

  AddJobEvent(this.job);
}

class GetCompaniesEvent extends ListEvent {
}

class AddCompanyEvent extends ListEvent {
  final CompanyLocalModel company;
  AddCompanyEvent(this.company);
}

class GetCompaniesJobsEvent extends ListEvent {
  final int remoteId;
  GetCompaniesJobsEvent(this.remoteId);
}

class DeleteCompanyEvent extends ListEvent {
  final  int localId;
  final  int remoteId;
  DeleteCompanyEvent(this.localId, this.remoteId);
}

class DeleteJobEvent extends ListEvent {
  final  int localId;
  final  int remoteId;
  DeleteJobEvent(this.localId, this.remoteId);
}