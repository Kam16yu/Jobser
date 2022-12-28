import 'package:domain/models/job_local_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobser/presentation/bloc/bloc.dart';
import 'package:jobser/presentation/bloc/events.dart';

class JobPage extends StatefulWidget {
  const JobPage({super.key,  required this.jobModel});
  final JobLocalModel jobModel;
  @override
  State<JobPage> createState() => _JobPageState();
}

class _JobPageState extends State<JobPage> {
  List<JobLocalModel> jobsList = [];
  @override
  void initState() {
    super.initState();
    BlocProvider.of<MainBloc>(context).add(GetJobsEvent());
  }

  @override
  Widget build(BuildContext context) {
    final JobLocalModel job = widget.jobModel;
    final MainBloc mainBloc = BlocProvider.of<MainBloc>(context);
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: Theme.of(context).colorScheme.outline,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
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
    );
  }
}
