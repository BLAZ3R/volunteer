import 'dart:typed_data';

import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:volunteer/components/RoundedButton.dart';
import 'package:volunteer/constants/MainTheme.dart';
import 'package:volunteer/data/api/EventApi.dart';
import 'package:volunteer/data/api/UserApi.dart';
import 'package:volunteer/data/models/Event.dart';
import 'package:volunteer/logic/util/util.dart';

class EventDetailedScreen extends StatefulWidget {
  EventDetailedScreen({Key? key, required this.event}) : super(key: key);
  final Event event;

  @override
  State<EventDetailedScreen> createState() => _EventDetailedScreenState();
}

class _EventDetailedScreenState extends State<EventDetailedScreen>
    with SingleTickerProviderStateMixin {
  late TabController _controller;

  late MapController _mapController;

  late bool isJoined = false;
  bool loaded = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = new TabController(length: 2, vsync: this, initialIndex: 0);
    _mapController = MapController(
      initMapWithUserPosition: false,
      initPosition:
          GeoPoint(latitude: widget.event.lat, longitude: widget.event.lng),
    );
    check();
  }

  Future<void> check() async {
    isJoined = await EventApi().isJoined(widget.event.id);
    setState(() {
      loaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final UriData? data = Uri.parse(widget.event.image).data;
    Uint8List? myImage = data?.contentAsBytes();
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Column(
          children: [
            Image.memory(
              myImage!,
              fit: BoxFit.cover,
              height: MediaQuery.of(context).size.height * 0.30,
            ),
            loaded
                ? _panel(context)
                : Center(child: CircularProgressIndicator()),
          ],
        ),
      ),
    );
  }

  Widget _panel(BuildContext context) {
    return MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: Container(
          decoration: BoxDecoration(
            color: MainTheme.of(context).primaryBackground,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10)),
          ),
          child: Column(children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
              child: Material(
                child: TabBar(
                  indicatorColor: MainTheme.of(context).primaryColor,
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.height * 0.05),
                  labelColor: MainTheme.of(context).primaryColor,
                  unselectedLabelColor: Colors.grey,
                  labelStyle: MainTheme.of(context).title3,
                  unselectedLabelStyle: MainTheme.of(context).title3,
                  controller: _controller,
                  tabs: const [
                    Tab(
                      text: "Детали",
                    ),
                    Tab(
                      text: "Контакты",
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.45,
              child: TabBarView(
                controller: _controller,
                children: <Widget>[_descriptionTab(), _contactTab()],
              ),
            ),
          ]),
        ));
  }

  Widget _descriptionTab() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.45,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(25, 10, 25, 0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    widget.event.name,
                    style: MainTheme.of(context).title1,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    widget.event.description,
                    style: MainTheme.of(context).bodyText1,
                  ),
                ],
              ),
              if (!widget.event.finished && !isJoined)
                RoundedButton(
                  press: () async {
                    bool val = await UserApi().joinEvent(widget.event.id);
                    if (val) {
                      setState(() {
                        isJoined = true;
                      });
                      showSnackbar(context, "Теперь вы участвуете в событии");
                    }
                  },
                  text: "Участвовать",
                  color: MainTheme.of(context).primaryColor,
                ),
              if (isJoined)
                RoundedButton(
                  press: () async {
                    bool val = await UserApi().leaveEvent(widget.event.id);
                    if (val) {
                      setState(() {
                        isJoined = false;
                      });
                      showSnackbar(context, "Вы покинули событие");
                    }
                  },
                  text: "Покинуть событие",
                  color: Colors.red,
                )
            ]),
      ),
    );
  }

  Widget _contactTab() {
    // if (_mapController != null) {
    //   _mapController.addMarker(
    //       GeoPoint(latitude: widget.event.lat, longitude: widget.event.lng),
    //       markerIcon: MarkerIcon(
    //           assetMarker:
    //               AssetMarker(image: AssetImage("asset/image/pin.png"))));
    // }

    return Container(
      height: MediaQuery.of(context).size.height * 0.45,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(25, 10, 25, 0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            children: [
              Text(
                "Организатор: ",
                style: MainTheme.of(context).title3,
              ),
              Text(
                widget.event.organizer.organizationName,
                style: MainTheme.of(context).bodyText1,
              ),
            ],
          ),
          Row(
            children: [
              Text(
                "Номер: ",
                style: MainTheme.of(context).title3,
              ),
              Text(
                "${widget.event.organizer.phoneNumber} ",
                style: MainTheme.of(context).bodyText1,
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Адрес на карте:",
            style: MainTheme.of(context).title3,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.25,
            width: MediaQuery.of(context).size.height * 0.25,
            child: OSMFlutter(
              controller: _mapController,
              trackMyPosition: false,
              initZoom: 14,
              minZoomLevel: 10,
              maxZoomLevel: 16,
              stepZoom: 1.0,
              onMapIsReady: (bool val) => val ? setMarker() : null,
              userLocationMarker: UserLocationMaker(
                personMarker: MarkerIcon(
                  icon: Icon(
                    Icons.location_history_rounded,
                    color: Colors.red,
                    size: 48,
                  ),
                ),
                directionArrowMarker: MarkerIcon(
                  icon: Icon(
                    Icons.double_arrow,
                    size: 48,
                  ),
                ),
              ),
              roadConfiguration: RoadConfiguration(
                startIcon: MarkerIcon(
                  icon: Icon(
                    Icons.person,
                    size: 64,
                    color: Colors.brown,
                  ),
                ),
                roadColor: Colors.yellowAccent,
              ),
              markerOption: MarkerOption(
                  defaultMarker: MarkerIcon(
                icon: Icon(
                  Icons.person_pin_circle,
                  color: Colors.blue,
                  size: 56,
                ),
              )),
            ),
          ),
        ]),
      ),
    );
  }

  void setMarker() {
    _mapController.addMarker(
        GeoPoint(latitude: widget.event.lat, longitude: widget.event.lng),
        markerIcon: MarkerIcon(
            assetMarker:
                AssetMarker(image: AssetImage("asset/image/pin.png"))));
  }
}
