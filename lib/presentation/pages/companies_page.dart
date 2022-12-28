import 'package:domain/models/company_local_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobser/presentation/bloc/bloc.dart';
import 'package:jobser/presentation/bloc/events.dart';
import 'package:jobser/presentation/bloc/states.dart';
import 'package:jobser/presentation/pages/add_company.dart';
import 'package:jobser/presentation/pages/company.dart';

class Companies extends StatefulWidget {
  const Companies({super.key, required this.companiesList});

  final List<CompanyLocalModel> companiesList;

  @override
  State<Companies> createState() => _CompaniesState();
}

class _CompaniesState extends State<Companies> {

  @override
  Widget build(BuildContext context) {
    List<CompanyLocalModel> companiesList = widget.companiesList;
    final MainBloc mainBloc = BlocProvider.of<MainBloc>(context);
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
                                child: CompanyPage(companyModel: company,),
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
                                    'ID: ${company.companyID}',
                                  ),
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
                    builder: (BuildContext context) =>
                        BlocProvider.value(
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
