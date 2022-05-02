import 'package:flutter/material.dart';
import 'package:volunteer/components/ListOfEvents.dart';
import 'package:volunteer/components/ListOfOrganizations.dart';

class HomeScreeen extends StatelessWidget {
  const HomeScreeen({Key? key}) : super(key: key);

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
        body: const SafeArea(
          child: TabBarView(
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: CustomScrollView(
                    clipBehavior: Clip.none, slivers: [ListOfEventsWidget()]),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: CustomScrollView(
                    clipBehavior: Clip.none, slivers: [ListOfOrganizations()]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
