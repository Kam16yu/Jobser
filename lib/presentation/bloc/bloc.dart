import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobser/presentation/bloc/events.dart';
import 'package:jobser/presentation/bloc/states.dart';

class MainBloc extends Bloc<ListEvent, ListState> {
  MainBloc() : super(ListInitState()) {
    on<GetJobsEvent>(getJobsEvent);
    on<PostJobEvent>(postJobEvent);
    on<GetCompaniesEvent>(getCompaniesEvent);
    on<PostCompaniesEvent>(postCompaniesEvent);
    on<GetCompaniesJobsEvent>(getCompaniesJobsEvent);
  }

  Future<void> getJobsEvent(
      GetJobsEvent element, Emitter<ListState> emitter,) async {
    emitter(UpdateJobState([]));
  }

  Future<void> postJobEvent(
    PostJobEvent event,
    Emitter<ListState> emitter,
  ) async {
    emitter(UpdateJobState([]));
  }

  Future<void> getCompaniesEvent(
    GetCompaniesEvent element,
    Emitter<ListState> emitter,
  ) async {
    emitter(UpdateCompanyState([]));
  }

  Future<void> postCompaniesEvent(
    PostCompaniesEvent element,
    Emitter<ListState> emitter,
  ) async {
    emitter(UpdateCompanyState([]));
  }

  Future<void> getCompaniesJobsEvent(
    GetCompaniesJobsEvent element,
    Emitter<ListState> emitter,
  ) async {
    emitter(UpdateJobState([]));
  }
}
