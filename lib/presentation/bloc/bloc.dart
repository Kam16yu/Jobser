import 'dart:async';

import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobser/presentation/bloc/events.dart';
import 'package:jobser/presentation/bloc/states.dart';

class MainBloc extends Bloc<ListEvent, ListState> {
  final AppManagement appManagement;

  MainBloc(this.appManagement) : super(ListInitState()) {
    on<GetJobsCompaniesEvent>(getJobsCompaniesEvent);
    on<AddJobEvent>(addJobEvent);
    on<GetCompaniesEvent>(getCompaniesEvent);
    on<AddCompanyEvent>(addCompanyEvent);
    on<GetCompaniesJobsEvent>(getCompaniesJobsEvent);
    on<DeleteCompanyEvent>(deleteCompanyEvent);
    on<DeleteJobEvent>(deleteJobEvent);
  }

  Future<void> getJobsCompaniesEvent(
    GetJobsCompaniesEvent event,
    Emitter<ListState> emitter,
  ) async {
    final List<JobLocalModel> jobsList = await appManagement.getJobs();
    final List<CompanyLocalModel> companiesList =
        await appManagement.getCompanies();
    emitter(UpdateJobsCompaniesState(jobsList, companiesList));
  }

  Future<void> getCompaniesEvent(
    GetCompaniesEvent event,
    Emitter<ListState> emitter,
  ) async {
    final List<CompanyLocalModel> result = await appManagement.getCompanies();
    emitter(UpdateCompaniesState(result));
  }

  Future<void> addJobEvent(
    AddJobEvent event,
    Emitter<ListState> emitter,
  ) async {
    await appManagement.addJob(event.job);
    final List<JobLocalModel> jobsResult = appManagement.getSavedJobs();
    final List<CompanyLocalModel> companiesList =
        appManagement.getSavedCompanies();
    emitter(UpdateJobsCompaniesState(jobsResult, companiesList));
  }

  Future<void> addCompanyEvent(
    AddCompanyEvent event,
    Emitter<ListState> emitter,
  ) async {
    await appManagement.addCompany(event.company);
    final List<CompanyLocalModel> result = await appManagement.getCompanies();
    emitter(UpdateCompaniesState(result));
  }

  Future<void> getCompaniesJobsEvent(
    GetCompaniesJobsEvent event,
    Emitter<ListState> emitter,
  ) async {
    final List<JobLocalModel> result =
        await appManagement.getCompanyJobs(event.remoteId);
    emitter(UpdateCompaniesJobState(result));
  }

  Future<void> deleteCompanyEvent(
    DeleteCompanyEvent event,
    Emitter<ListState> emitter,
  ) async {
    await appManagement.deleteCompany(event.localId, event.remoteId);
    final List<CompanyLocalModel> result = await appManagement.getCompanies();
    emitter(UpdateCompaniesState(result));
  }

  Future<void> deleteJobEvent(
    DeleteJobEvent event,
    Emitter<ListState> emitter,
  ) async {
    await appManagement.deleteJob(event.localId, event.remoteId);
    final List<JobLocalModel> jobsResult = await appManagement.getJobs();
    final List<CompanyLocalModel> companiesList =
        await appManagement.getCompanies();
    emitter(UpdateJobsCompaniesState(jobsResult, companiesList));
  }
}
