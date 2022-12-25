import 'package:domain/entities/job_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobser/presentation/bloc/bloc.dart';
import 'package:jobser/presentation/bloc/events.dart';
import 'package:jobser/presentation/bloc/states.dart';
import 'package:jobser/presentation/pages/companies_page.dart';

class JobsPage extends StatefulWidget {
  const JobsPage({super.key});

  @override
  State<JobsPage> createState() => _JobsPageState();
}

class _JobsPageState extends State<JobsPage> {
  List<JobModel> dataList = [];

  @override
  void initState() {
    super.initState();
    BlocProvider.of<MainBloc>(context).add(GetJobsEvent());
  }

  @override
  Widget build(BuildContext context) {
    final MainBloc mainBloc = BlocProvider.of<MainBloc>(context);

    return Column(
      children: [
        BlocConsumer<MainBloc, ListState>(
          listener: (context, state) {
            if (state is UpdateJobState) {
              dataList = state.jobs;
            }
          },
          builder: (context, state) {
            return Expanded(
              child: ListView.builder(
                itemCount: dataList.length,
                itemBuilder: (context, index) {
                  final JobModel job = dataList[index];

                  return Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: Theme.of(context).colorScheme.outline,
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          ' JobID: ${job.jobID}',
                        ),
                        Text(
                          ' CompanyID: ${job.companyID}',
                        ),
                        Text(' Job title: ${job.title}'),
                        Text(' Description: ${job.description}'),
                        Text(' City: ${job.city}'),
                      ],
                    ),
                  );
                },
              ),
            );
          },
        ),
        BottomAppBar(
          color: Colors.white38,
          elevation: 10,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Text(" Background:", style: TextStyle(fontSize: 25)),
                  IconButton(
                    padding: const EdgeInsets.fromLTRB(2.0, 2.0, 2.0, 2.0),
                    icon: const Icon(Icons.restart_alt_sharp),
                    iconSize: 40.0,
                    onPressed: () {
                      BlocProvider.of<MainBloc>(context)
                          .add(GetCompaniesJobsEvent());
                    },
                    tooltip: 'Restart background process',
                  ),
                  IconButton(
                    padding: const EdgeInsets.fromLTRB(2.0, 2.0, 2.0, 2.0),
                    icon: const Icon(Icons.stop),
                    iconSize: 40.0,
                    onPressed: () => {},
                    tooltip: 'Stop background process',
                  ),
                ],
              ),
              IconButton(
                padding: const EdgeInsets.fromLTRB(2.0, 2.0, 2.0, 2.0),
                icon: const Icon(Icons.cloud),
                iconSize: 40.0,
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) => BlocProvider.value(
                        value: mainBloc,
                        child: const Companies(),
                      ),
                    ),
                  );
                },
                tooltip: 'Cloud Archive',
              ),
              IconButton(
                padding: const EdgeInsets.fromLTRB(2.0, 2.0, 2.0, 2.0),
                icon: const Icon(Icons.add_box_rounded),
                iconSize: 40.0,
                onPressed: () {
                },
                tooltip: 'Check State',
              ),
            ],
          ),
        ),
      ],
    );
  }
}
