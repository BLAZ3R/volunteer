import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:volunteer/logic/blocs/event/event_bloc.dart';
import 'package:volunteer/logic/blocs/event/event_state.dart';

import '../data/models/Event.dart';
import '../logic/blocs/event/event_event.dart';

class CustomController extends MapController {
  CustomController({
    bool initMapWithUserPosition = true,
    GeoPoint? initPosition,
    BoundingBox? areaLimit = const BoundingBox.world(),
  })  : assert(
          initMapWithUserPosition || initPosition != null,
        ),
        super(
          initMapWithUserPosition: initMapWithUserPosition,
          initPosition: initPosition,
          areaLimit: areaLimit,
        );

  @override
  void init() {
    super.init();
  }
}

class MapOfEventsScreen extends StatefulWidget {
  MapOfEventsScreen({Key? key}) : super(key: key);

  @override
  _MapOfEventsScreenState createState() => _MapOfEventsScreenState();
}

class _MapOfEventsScreenState extends State<MapOfEventsScreen> {
  late CustomController controller;
  late GlobalKey<ScaffoldState> scaffoldKey;
  Key mapGlobalkey = UniqueKey();
  ValueNotifier<bool> zoomNotifierActivation = ValueNotifier(false);
  ValueNotifier<bool> visibilityZoomNotifierActivation = ValueNotifier(false);
  ValueNotifier<bool> advPickerNotifierActivation = ValueNotifier(false);
  ValueNotifier<bool> trackingNotifier = ValueNotifier(false);
  ValueNotifier<bool> showFab = ValueNotifier(true);
  ValueNotifier<GeoPoint?> lastGeoPoint = ValueNotifier(null);
  Timer? timer;
  int x = 0;

  @override
  void initState() {
    super.initState();
    controller = CustomController(
      initMapWithUserPosition: false,
      initPosition: GeoPoint(
        latitude: 51.169392,
        longitude: 71.449074,
      ),
    );
    scaffoldKey = GlobalKey<ScaffoldState>();
  }

  Future<void> mapIsInitialized() async {
    await controller.setZoom(zoomLevel: 14);
  }

  @override
  Future<void> mapIsReady(bool isReady) async {
    if (isReady) {
      await mapIsInitialized();
    }
  }

  @override
  void dispose() {
    if (timer != null && timer!.isActive) {
      timer?.cancel();
    }
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Карта событий'),
          actions: <Widget>[],
        ),
        body: buildMap());
  }

  Widget buildMap() {
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

        return Container(
          child: Stack(
            children: [
              OSMFlutter(
                controller: controller,
                trackMyPosition: false,
                androidHotReloadSupport: true,
                mapIsLoading: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      Text("Карта загружается"),
                    ],
                  ),
                ),
                onMapIsReady: (isReady) {
                  if (isReady) {
                    events.forEach((element) {
                      if (element.lat != null && element.lng != null) {
                        print(element.name);
                        setMarker(element);
                      }
                    });
                  }
                },
                initZoom: 11,
                minZoomLevel: 3,
                maxZoomLevel: 18,
                stepZoom: 1.0,
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
                showContributorBadgeForOSM: true,
                //trackMyPosition: trackingNotifier.value,
                showDefaultInfoWindow: false,
                onLocationChanged: (myLocation) {
                  print(myLocation);
                },

                roadConfiguration: RoadConfiguration(
                  startIcon: MarkerIcon(
                    icon: Icon(
                      Icons.person,
                      size: 64,
                      color: Colors.brown,
                    ),
                  ),
                  middleIcon: MarkerIcon(
                    icon: Icon(Icons.location_history_sharp),
                  ),
                  roadColor: Colors.red,
                ),
                markerOption: MarkerOption(
                  defaultMarker: MarkerIcon(
                    icon: Icon(
                      Icons.home,
                      color: Colors.orange,
                      size: 64,
                    ),
                  ),
                  advancedPickerMarker: MarkerIcon(
                    icon: Icon(
                      Icons.location_searching,
                      color: Colors.green,
                      size: 64,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 10,
                left: 10,
                child: Column(
                  children: [
                    ElevatedButton(
                      child: Icon(Icons.add),
                      onPressed: () async {
                        controller.zoomIn();
                      },
                    ),
                    ElevatedButton(
                      child: Icon(Icons.remove),
                      onPressed: () async {
                        controller.zoomOut();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void setMarker(Event event) {
    controller.addMarker(GeoPoint(latitude: event.lat, longitude: event.lng),
        markerIcon: MarkerIcon(
            assetMarker:
                AssetMarker(image: AssetImage("asset/image/pin.png"))));
  }
}
