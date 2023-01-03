import 'package:domain/models/company_local_model.dart';
import 'package:domain/models/job_local_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobser/presentation/bloc/bloc.dart';
import 'package:jobser/presentation/bloc/events.dart';
import 'package:jobser/presentation/pages/jobs_page.dart';

class AddJobPage extends StatefulWidget {
  const AddJobPage({super.key, required this.companiesList});

  final List<CompanyLocalModel> companiesList;

  @override
  State<AddJobPage> createState() => _AddJobPageState();
}

class _AddJobPageState extends State<AddJobPage> {
  int companyRemoteId = -1;
  String title = '';
  String description = '';
  String city = '';

  @override
  Widget build(BuildContext context) {
    final MainBloc mainBloc = BlocProvider.of<MainBloc>(context);
    final companiesList = widget.companiesList;

    if (companiesList.isNotEmpty && companyRemoteId == -1) {
      companyRemoteId = companiesList.first.companyID;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('New Vacancy'),
        centerTitle: true,
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.blueGrey,
              shape: const BeveledRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(2)),
              ),
              textStyle: const TextStyle(fontSize: 15),
            ),
            onPressed: () {
              mainBloc.add(
                AddJobEvent(
                  JobLocalModel(
                    jobLocalID: 0,
                    jobID: 0,
                    companyID: companyRemoteId,
                    title: title,
                    description: description,
                    city: city,
                  ),
                ),
              );
              mainBloc.add(GetJobsCompaniesEvent());
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (BuildContext context) => BlocProvider.value(
                    value: mainBloc,
                    child: const JobsPage(),
                  ),
                ),
              );
            },
            child: const Text("Save"),
          ),
        ],
      ),
      body: Card(
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
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: TextFormField(
                      maxLines: null,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Title',
                      ),
                      onChanged: (val) => setState(() {
                        title = val;
                      }),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: TextFormField(
                      maxLines: null,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Description',
                      ),
                      onChanged: (val) => setState(() {
                        description = val;
                      }),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: TextFormField(
                      maxLines: null,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'City',
                      ),
                      onChanged: (val) => setState(() {
                        city = val;
                      }),
                    ),
                  ),
                  DropdownButton<String>(
                    value: getDropListValue(companiesList, companyRemoteId),
                    items: companiesList.map((CompanyLocalModel value) {
                      return DropdownMenuItem<String>(
                        value:
                            '${value.name} ID: ${value.companyID.toString()}',
                        child: Text(value.name),
                      );
                    }).toList(),
                    onChanged: (e) {
                      setState(() {
                        final value =
                            e?.split('ID: ').last.replaceAll('ID: ', '');
                        companyRemoteId = int.tryParse(value!) ?? 0;
                      });
                    },
                    selectedItemBuilder: (BuildContext context) {
                      return widget.companiesList
                          .map<Widget>((CompanyLocalModel item) {
                        // This is the widget that will be shown when you select an item.
                        // Here custom text style, alignment and layout size can be applied
                        // to selected item string.
                        return Container(
                          alignment: Alignment.center,
                          constraints: const BoxConstraints(minWidth: 100),
                          child: Text(
                            item.name,
                            style: const TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        );
                      }).toList();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String getDropListValue(List<CompanyLocalModel> companiesList, int id) {
    final Iterable<CompanyLocalModel> companies =
        companiesList.where((e) => e.companyID == id);
    if (companies.isNotEmpty) {
      final CompanyLocalModel company = companies.first;

      return '${company.name} ID: ${company.companyID.toString()}';
    }

    return '';
  }
}
