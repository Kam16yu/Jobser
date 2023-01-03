import 'package:domain/models/company_local_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobser/presentation/bloc/bloc.dart';
import 'package:jobser/presentation/bloc/events.dart';
import 'package:jobser/presentation/pages/companies_page.dart';

class AddCompanyPage extends StatefulWidget {
  const AddCompanyPage({super.key});

  @override
  State<AddCompanyPage> createState() => _AddCompanyPageState();
}

class _AddCompanyPageState extends State<AddCompanyPage> {
  String name = '';
  String description = '';
  String industry = '';

  @override
  Widget build(BuildContext context) {
    final MainBloc mainBloc = BlocProvider.of<MainBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('New Company'),
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
                AddCompanyEvent(
                  CompanyLocalModel(
                    companyLocalID: 0,
                    companyID: 0,
                    name: name,
                    description: description,
                    industry: industry,
                  ),
                ),
              );
              mainBloc.add(GetCompaniesEvent());
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (BuildContext context) => BlocProvider.value(
                    value: mainBloc,
                    child: const CompaniesPage(),
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
                        hintText: 'Name',
                      ),
                      onChanged: (val) => setState(() {
                        name = val;
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
                        hintText: 'Industry',
                      ),
                      onChanged: (val) => setState(() {
                        industry = val;
                      }),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
