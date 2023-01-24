import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';
import 'package:openstreetmap/saved_places.dart';
Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const OsMap(),
    );
  }
}
class OsMap extends StatefulWidget {
  const OsMap({
    Key? key,
    this.width,
    this.height,
  }) : super(key: key);

  final double? width;
  final double? height;

  @override
  _OsMapState createState() => _OsMapState();
}

class _OsMapState extends State<OsMap> {
  CollectionReference places = FirebaseFirestore.instance.collection('Places');

  Future<void> addPlace(String city, double lat, double long) {
    return places.add({'City': city, 'lat': lat, 'long': long}).catchError(
        (error) => print("Failed to add place: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
  child: ListView(
    padding: EdgeInsets.zero,
    children: [
      const DrawerHeader(
        decoration: BoxDecoration(
          color: Colors.blue,
        ),
        child: Text('Drawer Header'),
      ),
      ListTile(
        title: const Text('Saved places'),
        onTap: () {
          Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>  SavedPlaces()));
        },
      ),
    ],
  ),
),
      appBar: AppBar(title: Text('3GIS')),
      body: OpenStreetMapSearchAndPick(
          center: LatLong(43, 76),
          buttonColor: Colors.blue,
          buttonText: 'Save this Location',
          onPicked: (pickedData) {
             addPlace(pickedData.address, pickedData.latLong.latitude,
                pickedData.latLong.longitude);
          }),
    );
  }
}
