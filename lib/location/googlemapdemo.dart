import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app/location/MarkerGenerator.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_cluster_manager/google_maps_cluster_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'dart:ui' as ui;

class GoogleMapsDemo extends StatefulWidget {
  @override
  _GoogleMapsDemoState createState() => _GoogleMapsDemoState();
}

class _GoogleMapsDemoState extends State<GoogleMapsDemo> {
  LatLng initialPosition1 = LatLng(22.2926185, 70.8042563);
  LatLng initialPosition2 = LatLng(23.2926185, 70.8042563);
  GoogleMapController googleMapController;
  Location location = Location();
  Set<Marker> _markers = {};
  BitmapDescriptor pinLocationIcon;

  double _originLatitude = 6.5212402, _originLongitude = 3.3679965;
  double _destLatitude = 6.849660, _destLongitude = 3.648190;
  Map<MarkerId, Marker> markers = {};
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  String googleAPiKey = 'AIzaSyD8WQMFMo-4qURHnZrKzVllLhVsXyo3doU';


  Set<Marker> markersClusters = Set();

  ClusterManager _manager;
  final CameraPosition _parisCameraPosition =
  CameraPosition(target: LatLng(48.856613, 2.352222), zoom: 12.0);

  List<ClusterItem<Place>> items = [
    for (int i = 0; i < 10; i++)
      ClusterItem(LatLng(48.848200 + i * 0.001, 2.319124 + i * 0.001),
          item: Place(name: 'Place $i')),
    for (int i = 0; i < 10; i++)
      ClusterItem(LatLng(48.858265 - i * 0.001, 2.350107 + i * 0.001),
          item: Place(name: 'Restaurant $i', isClosed: i % 2 == 0)),
    for (int i = 0; i < 10; i++)
      ClusterItem(LatLng(48.858265 + i * 0.01, 2.350107 - i * 0.01),
          item: Place(name: 'Bar $i')),
    for (int i = 0; i < 10; i++)
      ClusterItem(LatLng(48.858265 - i * 0.1, 2.350107 - i * 0.01),
          item: Place(name: 'Hotel $i')),
    for (int i = 0; i < 10; i++)
      ClusterItem(LatLng(48.858265 + i * 0.1, 2.350107 + i * 0.1)),
    for (int i = 0; i < 10; i++)
      ClusterItem(LatLng(48.858265 + i * 1, 2.350107 + i * 1)),
  ];

  void onMapCreated(GoogleMapController controller) {
    print('dddddd');
    googleMapController = controller;
    location.onLocationChanged.listen((event) {
      print('aaaaaa');
      // googleMapController.animateCamera(CameraUpdate.newCameraPosition(
      //     CameraPosition(target: LatLng(event.latitude, event.longitude),
      //     zoom: 10,
      //     bearing: 90,
      //     tilt: 45)));
      setState(() {
        _markers.add(
            Marker(
                markerId: MarkerId('1'),
                position: initialPosition1,
                icon: pinLocationIcon
            )
        );
        _markers.add(
            Marker(
                markerId: MarkerId('2'),
                position: initialPosition2,
                icon: pinLocationIcon
            )
        );
      });
    });
  }
  GlobalKey iconKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    // initPinLocationIcon();
    customMarker();

    // /// origin marker
    // _addMarker(LatLng(_originLatitude, _originLongitude), "origin",
    //     BitmapDescriptor.defaultMarker);
    //
    // /// destination marker
    // _addMarker(LatLng(_destLatitude, _destLongitude), "destination",
    //     BitmapDescriptor.defaultMarkerWithHue(90));
    _getPolyline();

    _manager = _initClusterManager();
  }

  initPinLocationIcon() async {
    pinLocationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'assets/usa.png');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: iconKey,
      appBar: AppBar(
        title: Text('Google Map'),
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              // target: LatLng(48.856613, 2.352222), zoom: 10),
              target: LatLng(_originLatitude,_originLongitude), zoom: 10),
              //   target: LatLng(_originLatitude, _originLongitude), zoom: 10),
            // mapType: MapType.satellite,
            onMapCreated: onMapCreated,
            myLocationEnabled: true,
            tiltGesturesEnabled: true,
            compassEnabled: true,
            scrollGesturesEnabled: true,
            zoomGesturesEnabled: true,
            markers: Set<Marker>.of(markers.values),
            polylines: Set<Polyline>.of(polylines.values),
          ),
        ],
      ),
    );
  }

  _addMarker(LatLng position, String id, BitmapDescriptor descriptor) {
    MarkerId markerId = MarkerId(id);
    Marker marker =
    Marker(markerId: markerId, icon: pinLocationIcon, position: position);
    markers[markerId] = marker;
  }

  _addPolyLine() {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(polylineId: id, color: Colors.red, points: polylineCoordinates);
    polylines[id] = polyline;
    setState(() {});
  }

  _getPolyline() async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        googleAPiKey,
        PointLatLng(_originLatitude, _originLongitude),
        PointLatLng(_destLatitude, _destLongitude),
        travelMode: TravelMode.driving,
        wayPoints: [PolylineWayPoint(location: "Direction API")]
    );
    print(result.points.length.toString() + " poly");
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }
    _addPolyLine();
  }

  ClusterManager _initClusterManager() {
    return ClusterManager<Place>(items, _updateMarkers,
        markerBuilder: _markerBuilder,
        initialZoom: _parisCameraPosition.zoom,
        stopClusteringZoom: 17.0);
  }

  void _updateMarkers(Set<Marker> markers) {
    print('Updated ${markers.length} markers');
    setState(() {
      this.markersClusters = markers;
    });
  }

  Future<Marker> Function(Cluster<Place>) get _markerBuilder =>
          (cluster) async {
        return Marker(
          markerId: MarkerId(cluster.getId()),
          position: cluster.location,
          onTap: () {
            print('---- $cluster');
            cluster.items.forEach((p) => print(p));
          },
          icon: await _getMarkerBitmap(cluster.isMultiple ? 125 : 75,
              text: cluster.isMultiple ? cluster.count.toString() : null),
        );
      };

  Future<BitmapDescriptor> _getMarkerBitmap(int size, {String text}) async {
    assert(size != null);

    final PictureRecorder pictureRecorder = PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);
    final Paint paint1 = Paint()..color = Colors.red;
    final Paint paint2 = Paint()..color = Colors.white;

    canvas.drawCircle(Offset(size / 2, size / 2), size / 2.0, paint1);
    canvas.drawCircle(Offset(size / 2, size / 2), size / 2.2, paint2);
    canvas.drawCircle(Offset(size / 2, size / 2), size / 2.8, paint1);

    if (text != null) {
      TextPainter painter = TextPainter(textDirection: TextDirection.ltr);
      painter.text = TextSpan(
        text: text,
        style: TextStyle(
            fontSize: size / 3,
            color: Colors.white,
            fontWeight: FontWeight.normal),
      );
      painter.layout();
      painter.paint(
        canvas,
        Offset(size / 2 - painter.width / 2, size / 2 - painter.height / 2),
      );
    }

    final img = await pictureRecorder.endRecording().toImage(size, size);
    final data = await img.toByteData(format: ImageByteFormat.png);

    return BitmapDescriptor.fromBytes(data.buffer.asUint8List());
  }


  void customMarker() async {
    RepaintBoundary(
      key: iconKey,
      child: IconButton(icon: Icon(Icons.star),
          onPressed: () {
            // Do something
          }),
    );
    await getCustomIcon(iconKey);
  }

  Future<BitmapDescriptor> getCustomIcon(GlobalKey iconKey) async {
    Future<Uint8List> _capturePng(GlobalKey iconKey) async {
      try {
        print('inside');
        RenderRepaintBoundary boundary = iconKey.currentContext.findRenderObject();
        ui.Image image = await boundary.toImage(pixelRatio: 3.0);
        ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
        return byteData.buffer.asUint8List();
      } catch (e) {
        print(e);
      }
    }

    MarkerGenerator([FlutterLogo()], (bitmaps) async {
      pinLocationIcon = BitmapDescriptor.fromBytes(bitmaps[0]);
      /// origin marker
      _addMarker(LatLng(_originLatitude, _originLongitude), "origin",
          BitmapDescriptor.defaultMarker);

      /// destination marker
      _addMarker(LatLng(_destLatitude, _destLongitude), "destination",
          BitmapDescriptor.defaultMarkerWithHue(90));
      if(mounted) setState(() {});
    }).generate(context);

  }

  GlobalKey _globalKey = new GlobalKey();

  bool inside = false;
  Uint8List imageInMemory;

  Future<Uint8List> _capturePng() async {
    try {
      print('inside');
      inside = true;
      RenderRepaintBoundary boundary =
      _globalKey.currentContext.findRenderObject();
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData byteData =
      await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData.buffer.asUint8List();
//      String bs64 = base64Encode(pngBytes);
//      print(pngBytes);
//      print(bs64);
      print('png done');
      setState(() {
        imageInMemory = pngBytes;
        inside = false;
      });
      return pngBytes;
    } catch (e) {
      print(e);
    }
  }

}

class Place {
  String name;
  bool isClosed;
  Place({this.name, this.isClosed});
}

