import 'package:data/core/sources_operations.dart';
import 'package:domain/repository/sources_repository.dart';
import 'package:domain/use_cases/app_management.dart';
import 'package:injector/injector.dart';
import 'package:jobser/presentation/bloc/bloc.dart';
import 'package:remote/core/remote_operations_impl.dart';

class InstancesInject {
  // Factory return only once static class object
  factory InstancesInject() => _instance;

  //Basic constructor
  InstancesInject._internal();

  //Static class object
  static final InstancesInject _instance = InstancesInject._internal();

  //C
  Future<void> setup() async {
    Injector.appInstance
      ..registerSingleton<RestClient>(
        () => RestClient(),
      )
      ..registerSingleton<SourcesRepository>(
        () => DbAndRemoteOperations(
          Injector.appInstance.get<RestClient>(),
        ),
      )
      ..registerSingleton<AppManagement>(
        () => AppManagement(Injector.appInstance.get<SourcesRepository>()),
      )
      ..registerSingleton<MainBloc>(
        () => MainBloc(
          Injector.appInstance.get<AppManagement>(),
        ),
      );
  }
}
