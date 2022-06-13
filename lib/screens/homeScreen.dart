import 'package:flutter/material.dart';
import 'package:volunteer/components/ListOfEvents.dart';
import 'package:volunteer/components/ListOfOrganizations.dart';
import 'package:volunteer/data/api/EventApi.dart';

import '../data/models/Event.dart';

class HomeScreeen extends StatelessWidget {
  HomeScreeen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 20,
          bottom: const TabBar(
            tabs: [
              Tab(
                text: "События",
              ),
              Tab(
                text: "Организации",
              )
            ],
          ),
        ),
        body: SafeArea(
          child: TabBarView(
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: ListOfEvents(),
              ),
              Padding(
                  padding: EdgeInsets.all(8.0), child: ListOfOrganizations()),
            ],
          ),
        ),
      ),
    );
  }
}
