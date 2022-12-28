import 'package:domain/models/job_local_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobser/presentation/bloc/bloc.dart';
import 'package:jobser/presentation/bloc/events.dart';
import 'package:jobser/presentation/bloc/states.dart';
import 'package:jobser/presentation/pages/companies_page.dart';
import 'package:jobser/presentation/pages/job.dart';

class JobsPage extends StatefulWidget {
  const JobsPage({super.key});

  @override
  State<JobsPage> createState() => _JobsPageState();
}

class _JobsPageState extends State<JobsPage> {
  List<JobLocalModel> jobsList = [];

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
            if (state is UpdateJobsState) {
              jobsList = state.jobs;
            }
          },
          builder: (context, state) {
            return Expanded(
              child: ListView.builder(
                itemCount: jobsList.length,
                itemBuilder: (context, index) {
                  final JobLocalModel job = jobsList[index];

                  return InkWell(
                    splashColor: Colors.blue.withAlpha(30),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) => BlocProvider.value(
                            value: mainBloc,
                            child: JobPage(jobModel: job),
                          ),
                        ),
                      );
                    },
                    //CARD BODY
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: Theme.of(context).colorScheme.outline,
                        ),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12)),
                      ),
                      child: Row(
                        children: [
                          Expanded(
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
                          ),
                          IconButton(
                            padding: const EdgeInsets.fromLTRB(
                              8.0,
                              8.0,
                              20.0,
                              8.0,
                            ),
                            icon: const Icon(Icons.delete),
                            onPressed: () async {
                              mainBloc.add(
                                DeleteJobEvent(
                                  job.jobLocalID,
                                  job.jobID,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
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
                  IconButton(
                    padding: const EdgeInsets.fromLTRB(2.0, 2.0, 2.0, 2.0),
                    icon: const Icon(Icons.restart_alt_sharp),
                    iconSize: 40.0,
                    onPressed: () {
                      mainBloc.add(GetJobsEvent());
                    },
                    tooltip: 'Update jobs',
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
                icon: const Icon(Icons.add_business),
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
                tooltip: 'Companies',
              ),
              IconButton(
                padding: const EdgeInsets.fromLTRB(2.0, 2.0, 2.0, 2.0),
                icon: const Icon(Icons.add_box_rounded),
                iconSize: 40.0,
                onPressed: () {},
                tooltip: 'Add Job',
              ),
            ],
          ),
        ),
      ],
    );
  }
}
