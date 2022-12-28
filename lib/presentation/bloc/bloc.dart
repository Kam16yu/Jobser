import 'dart:async';

import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobser/presentation/bloc/events.dart';
import 'package:jobser/presentation/bloc/states.dart';

class MainBloc extends Bloc<ListEvent, ListState> {
  AppManagement appManagement;

  MainBloc(this.appManagement) : super(ListInitState()) {
    on<GetJobsEvent>(getJobsEvent);
    on<AddJobEvent>(postJobEvent);
    on<GetCompaniesEvent>(getCompaniesEvent);
    on<AddCompanyEvent>(postCompaniesEvent);
    on<GetCompaniesJobsEvent>(getCompaniesJobsEvent);
    on<DeleteCompanyEvent>(deleteCompanyEvent);
    on<DeleteJobEvent>(deleteJobEvent);
  }

  Future<void> getJobsEvent(
    GetJobsEvent event,
    Emitter<ListState> emitter,
  ) async {
    final List<JobLocalModel> result = await appManagement.getJobs();
    emitter(UpdateJobsState(result));
  }

  Future<void> getCompaniesEvent(
    GetCompaniesEvent event,
    Emitter<ListState> emitter,
  ) async {
    final List<CompanyLocalModel> result = await appManagement.getCompanies();
    emitter(UpdateCompaniesState(result));
  }

  Future<void> postJobEvent(
    AddJobEvent event,
    Emitter<ListState> emitter,
  ) async {
    emitter(UpdateJobsState([]));
  }

  Future<void> postCompaniesEvent(
    AddCompanyEvent event,
    Emitter<ListState> emitter,
  ) async {
    emitter(UpdateCompaniesState([]));
  }

  Future<void> getCompaniesJobsEvent(
    GetCompaniesJobsEvent event,
    Emitter<ListState> emitter,
  ) async {
    final List<JobLocalModel> result =
        await appManagement.getCompanyJobs(event.remoteId);
    emitter(UpdateCompaniesJobState(result));
  }

  Future<void>deleteCompanyEvent (
      DeleteCompanyEvent event,
      Emitter<ListState> emitter,
      ) async{
    await appManagement.deleteCompany(event.localId, event.remoteId);
    final List<CompanyLocalModel> result = await appManagement.getCompanies();
    emitter(UpdateCompaniesState(result));
  }

  Future<void>deleteJobEvent (
      DeleteJobEvent event,
      Emitter<ListState> emitter,
      ) async{
    await appManagement.deleteJob(event.localId, event.remoteId);
    final List<JobLocalModel> result = await appManagement.getJobs();
    emitter(UpdateJobsState(result));
  }
}
