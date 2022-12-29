import 'package:domain/models/company_local_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobser/presentation/bloc/bloc.dart';
import 'package:jobser/presentation/bloc/events.dart';
import 'package:jobser/presentation/pages/companies_page.dart';

class CompanyPage extends StatefulWidget {
  const CompanyPage({super.key, required this.companyModel});

  final CompanyLocalModel companyModel;

  @override
  State<CompanyPage> createState() => _CompanyPageState();
}

class _CompanyPageState extends State<CompanyPage> {

  @override
  void initState() {
    super.initState();
    BlocProvider.of<MainBloc>(context).add(GetJobsCompaniesEvent());
  }

  @override
  Widget build(BuildContext context) {
    final CompanyLocalModel company = widget.companyModel;
    final MainBloc mainBloc = BlocProvider.of<MainBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Company ${company.name}'),
        centerTitle: true,
      ),
      body: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Theme.of(context).colorScheme.outline,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(style: const TextStyle(fontSize: 20),
                    company.name,),
                  Text(style: const TextStyle(fontSize: 20),
                    'Description: ${company.description}',),
                  Text(style: const TextStyle(fontSize: 20),
                    'Industry: ${company.industry}',),
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
                  DeleteCompanyEvent(
                    company.companyLocalID,
                    company.companyID,
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
            ),
          ],
        ),
      ),
    );
  }
}
