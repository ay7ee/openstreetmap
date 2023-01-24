import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:openstreetmap/places.dart';

class SavedPlaces extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: StreamBuilder<List<Place>> (
        stream: readPlace(),
        builder: (context, snapshot){
          if(snapshot.hasError){
            return Text("something went wrong");
          }
          if(snapshot.hasData){
            final places = snapshot.data!;
            return ListView(
              children: places.map(buildplace).toList(), 
            );
          }
          else{
            return Center(child: CircularProgressIndicator(),);
          }

        } ,
      ),
    );
  }
}

Widget buildplace(Place place)=> ListTile(
  title: Text("Place: ${place.city}"),
  subtitle: Text("Lat: ${place.lat} \nLong: ${place.long} \n ---------------------------"),
  
);

Stream<List<Place>> readPlace()=> FirebaseFirestore.instance.collection('Places').snapshots().map((snapshot) => snapshot.docs.map((doc) => Place.fromJson(doc.data())).toList());

