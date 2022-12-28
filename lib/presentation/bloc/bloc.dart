import 'dart:async';

import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobser/presentation/bloc/events.dart';
import 'package:jobser/presentation/bloc/states.dart';

class MainBloc extends Bloc<ListEvent, ListState> {
  final AppManagement _appManagement;
  MainBloc(this._appManagement) : super(ListInitState()) {
    on<GetJobsEvent>(getJobsEvent);
    on<AddJobEvent>(addJobEvent);
    on<GetCompaniesEvent>(getCompaniesEvent);
    on<AddCompanyEvent>(addCompanysEvent);
    on<GetCompaniesJobsEvent>(getCompaniesJobsEvent);
    on<DeleteCompanyEvent>(deleteCompanyEvent);
    on<DeleteJobEvent>(deleteJobEvent);
  }

  Future<void> getJobsEvent(
    GetJobsEvent event,
    Emitter<ListState> emitter,
  ) async {
    final List<JobLocalModel> jobsResult = await _appManagement.getJobs();
    final List<CompanyLocalModel> companiesList =
    await _appManagement.getCompanies();
    emitter(UpdateJobsState(jobsResult, companiesList));
  }

  Future<void> getCompaniesEvent(
    GetCompaniesEvent event,
    Emitter<ListState> emitter,
  ) async {
    final List<CompanyLocalModel> result = await _appManagement.getCompanies();
    emitter(UpdateCompaniesState(result));
  }

  Future<void> addJobEvent(
    AddJobEvent event,
    Emitter<ListState> emitter,
  ) async {
    await _appManagement.addJob(event.job);
    final List<JobLocalModel> jobsResult = _appManagement.getSavedJobs();
    final List<CompanyLocalModel> companiesList = _appManagement.getSavedCompanies();
    emitter(UpdateJobsState(jobsResult, companiesList));
  }

  Future<void> addCompanysEvent(
    AddCompanyEvent event,
    Emitter<ListState> emitter,
  ) async {
    await _appManagement.addCompany(event.company);
    // emitter(UpdateCompaniesState([]));
  }

  Future<void> getCompaniesJobsEvent(
    GetCompaniesJobsEvent event,
    Emitter<ListState> emitter,
  ) async {
    final List<JobLocalModel> result =
        await _appManagement.getCompanyJobs(event.remoteId);
    emitter(UpdateCompaniesJobState(result));
  }

  Future<void> deleteCompanyEvent(
    DeleteCompanyEvent event,
    Emitter<ListState> emitter,
  ) async {
    await _appManagement.deleteCompany(event.localId, event.remoteId);
    final List<CompanyLocalModel> result = await _appManagement.getCompanies();
    emitter(UpdateCompaniesState(result));
  }

  Future<void> deleteJobEvent(
    DeleteJobEvent event,
    Emitter<ListState> emitter,
  ) async {
    await _appManagement.deleteJob(event.localId, event.remoteId);
    final List<JobLocalModel> jobsResult = await _appManagement.getJobs();
    final List<CompanyLocalModel> companiesList =
        await _appManagement.getCompanies();
    emitter(UpdateJobsState(jobsResult, companiesList));
  }
}
