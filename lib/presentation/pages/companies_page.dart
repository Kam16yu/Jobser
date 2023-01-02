import 'package:domain/models/company_local_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobser/presentation/bloc/bloc.dart';
import 'package:jobser/presentation/bloc/events.dart';
import 'package:jobser/presentation/bloc/states.dart';
import 'package:jobser/presentation/pages/add_company.dart';
import 'package:jobser/presentation/pages/company.dart';

class CompaniesPage extends StatefulWidget {
  const CompaniesPage({super.key, this.companiesList});

  final List<CompanyLocalModel>? companiesList;

  @override
  State<CompaniesPage> createState() => _CompaniesPageState();
}

class _CompaniesPageState extends State<CompaniesPage> {
  List<CompanyLocalModel> companiesList = [];

  @override
  Widget build(BuildContext context) {
    final MainBloc mainBloc = BlocProvider.of<MainBloc>(context);
    if (widget.companiesList.runtimeType != Null) {
      companiesList = widget.companiesList!;
    } else {
      companiesList = mainBloc.appManagement.getSavedCompanies();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Companies'),
      ),
      body: Column(
        children: [
          BlocConsumer<MainBloc, ListState>(
            listener: (context, state) {
              if (state is UpdateCompaniesState) {
                companiesList = state.companies;
              }
              if (state is UpdateJobsCompaniesState) {
                companiesList = state.companies;
              }
            },
            builder: (context, state) {

              return Expanded(
                child: ListView.builder(
                  itemCount: companiesList.length,
                  itemBuilder: (context, index) {
                    final CompanyLocalModel company = companiesList[index];

                    return Card(
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: Theme.of(context).colorScheme.outline,
                        ),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(4)),
                      ),
                      child: InkWell(
                        splashColor: Colors.blue.withAlpha(30),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  BlocProvider.value(
                                value: mainBloc,
                                child: CompanyPage(
                                  companyModel: company,
                                ),
                              ),
                            ),
                          );
                        },
                        //CARD BODY
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Name: ${company.name},',
                                  ),
                                  Text(
                                    'Description: ${company.description}',
                                    softWrap: true,
                                  ),
                                  Text('Industry: ${company.industry}'),
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
        ],
      ),
      bottomNavigationBar: BottomAppBar(
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
                    mainBloc.add(GetCompaniesEvent());
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
                      child: const AddCompanyPage(),
                    ),
                  ),
                );
              },
              tooltip: 'Add Job',
            ),
          ],
        ),
      ),
    );
  }
}
