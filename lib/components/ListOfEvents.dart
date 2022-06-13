import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:volunteer/components/EventInfoForm.dart';
import 'package:volunteer/components/OrganizationInfoForm.dart';
import 'package:volunteer/data/models/Event.dart';
import 'package:volunteer/logic/blocs/event/event_bloc.dart';
import 'package:volunteer/logic/blocs/event/event_event.dart';
import 'package:volunteer/logic/blocs/event/event_state.dart';
import 'package:volunteer/screens/eventDetailedScreen.dart';

class ListOfEvents extends StatelessWidget {
  const ListOfEvents({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<EventBloc>().add(
          EventFetched(),
        );
    return BlocBuilder<EventBloc, EventState>(
      builder: (context, state) {
        List<Event> events = [];

        if (state is EventLoadFailure) {
          return Text(state.errorMessage);
        }
        if (state is EventLoadInProgress) {
          return Center(child: CircularProgressIndicator());
        }
        if (state is EventLoadSuccess) {
          events = state.events;
        }
        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 240,
            childAspectRatio: 2 / 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 32,
          ),
          itemCount: events.length,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (builder) =>
                            EventDetailedScreen(event: events[index])));
              },
              child: EventInfoFormWidget(
                date: events[index].date,
                url: events[index].image,
                address: events[index].city,
                title: events[index].name,
              ),
            );
          },
        );
      },
    );
  }
}
