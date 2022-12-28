import 'package:domain/models/company_local_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobser/presentation/bloc/bloc.dart';
import 'package:jobser/presentation/bloc/events.dart';
import 'package:jobser/presentation/bloc/states.dart';

class Companies extends StatefulWidget {
  const Companies({super.key});

  @override
  State<Companies> createState() => _CompaniesState();
}

class _CompaniesState extends State<Companies> {
  List<CompanyLocalModel> companiesList = [];

  @override
  void initState() {
    super.initState();
    BlocProvider.of<MainBloc>(context).add(GetCompaniesEvent());
  }

  @override
  Widget build(BuildContext context) {
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
                            const BorderRadius.all(Radius.circular(12)),
                      ),
                      child: InkWell(
                        splashColor: Colors.blue.withAlpha(30),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  BlocProvider.value(
                                value: mainBloc,
                                child: const Companies(),
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
                                    ' ID: ${company.companyID}',
                                  ),
                                  Text(
                                    ' Name: ${company.name},',
                                  ),
                                  Text(
                                    ' Description: ${company.description}',
                                    softWrap: true,
                                  ),
                                  Text(' Industry: ${company.industry}'),
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
                                  DeleteCompanyEvent(
                                    company.companyLocalID,
                                    company.companyID,
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
        ],
      ),
    );
  }
}
