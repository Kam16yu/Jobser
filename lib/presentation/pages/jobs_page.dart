import 'package:domain/models/company_local_model.dart';
import 'package:domain/models/job_local_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobser/presentation/bloc/bloc.dart';
import 'package:jobser/presentation/bloc/events.dart';
import 'package:jobser/presentation/bloc/states.dart';
import 'package:jobser/presentation/pages/add_job.dart';
import 'package:jobser/presentation/pages/companies_page.dart';
import 'package:jobser/presentation/pages/job.dart';

class JobsPage extends StatefulWidget {
  const JobsPage({super.key});

  @override
  State<JobsPage> createState() => _JobsPageState();
}

class _JobsPageState extends State<JobsPage> {
  List<JobLocalModel> jobsList = [];
  List<CompanyLocalModel> companiesList = [];

  @override
  void initState() {
    super.initState();
    BlocProvider.of<MainBloc>(context).add(GetJobsCompaniesEvent());
  }

  @override
  Widget build(BuildContext context) {
    final MainBloc mainBloc = BlocProvider.of<MainBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Jobs'),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.lightBlueAccent,
              shape: const BeveledRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(2)),
              ),
              textStyle: const TextStyle(fontSize: 15),
            ),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) => BlocProvider.value(
                    value: mainBloc,
                    child: CompaniesPage(companiesList: companiesList),
                  ),
                ),
              );
            },
            child: const Text("Companies"),
          )
        ],
      ),
      //Implementing Bloc in app
      body: Column(
        children: [
          BlocConsumer<MainBloc, ListState>(
            listener: (context, state) {
              if (state is UpdateJobsCompaniesState) {
                jobsList = state.jobs;
                companiesList = state.companies;
              }
            },
            builder: (context, state) {
              return Expanded(
                child: ListView.builder(
                  itemCount: jobsList.length,
                  itemBuilder: (context, index) {
                    String companyName = '';
                    final JobLocalModel job = jobsList[index];
                    final Iterable<CompanyLocalModel> companies = companiesList
                        .where((e) => e.companyID == job.companyID);
                    if (companies.isNotEmpty) {
                      companyName = companies.first.name;
                    }

                    return InkWell(
                      splashColor: Colors.blue.withAlpha(30),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                BlocProvider.value(
                              value: mainBloc,
                              child: JobPage(
                                jobModel: job,
                                companyName: companyName,
                              ),
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
                              const BorderRadius.all(Radius.circular(4)),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text('Job title: ${job.title}'),
                                  Text(
                                    'Company: $companyName',
                                  ),
                                  Text('Description: ${job.description}'),
                                  Text('City: ${job.city}'),
                                ],
                              ),
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
                      icon: const Icon(Icons.restart_alt_rounded),
                      iconSize: 40.0,
                      onPressed: () {
                        mainBloc.add(GetJobsCompaniesEvent());
                      },
                      tooltip: 'Update jobs',
                    ),
                  ],
                ),
                IconButton(
                  padding: const EdgeInsets.fromLTRB(2.0, 2.0, 2.0, 2.0),
                  icon: const Icon(Icons.add_box_rounded),
                  iconSize: 40.0,
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) => BlocProvider.value(
                          value: mainBloc,
                          child: AddJobPage(companiesList: companiesList),
                        ),
                      ),
                    );
                  },
                  tooltip: 'Add Job',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
