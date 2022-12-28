import 'package:domain/models/job_local_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobser/presentation/bloc/bloc.dart';
import 'package:jobser/presentation/bloc/events.dart';

class JobPage extends StatefulWidget {
  const JobPage({super.key, required this.jobModel, required this.companyName});

  final JobLocalModel jobModel;
  final String companyName;
  @override
  State<JobPage> createState() => _JobPageState();
}

class _JobPageState extends State<JobPage> {

  @override
  Widget build(BuildContext context) {
    final JobLocalModel job = widget.jobModel;
    final MainBloc mainBloc = BlocProvider.of<MainBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Job ${job.title}'),
        centerTitle: true,
      ),
      body: Card(
        color: Colors.lightBlueAccent,
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
                  Text(style: const TextStyle(fontSize: 20),
                      ' ${job.title}',),
                  Text(style: const TextStyle(fontSize: 20),
                    ' Company: ${widget.companyName}',
                  ),
                  Text(style: const TextStyle(fontSize: 20),
                      ' Description: ${job.description}',),
                  Text(style: const TextStyle(fontSize: 20),
                      ' City: ${job.city}',),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white38,
        elevation: 10,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
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
  }
}
