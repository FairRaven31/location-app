import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:ip_address_app/models/ip_json_model.dart';
import 'package:ip_address_app/screens/country_details.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<LocationData> getLocationData() async {
    final response = await get(Uri.parse("http://ip-api.com/json/"));
    if (response.statusCode == 200) {
      return LocationData.fromJSON(jsonDecode(response.body));
    } else {
      throw Exception("Not Found boss.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: FutureBuilder(
          future: getLocationData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasData) {
              final details = snapshot.data;
              return LocationDataWidget(
                locationData: details,
              );
            } else {
              return Text(snapshot.error.toString());
            }
          },
        ),
      ),
    );
  }
}

class LocationDataWidget extends StatelessWidget {
  const LocationDataWidget({super.key, this.locationData});

  final LocationData? locationData;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 200,
            height: 100,
            decoration: BoxDecoration(
                color: Colors.teal.shade900,
                borderRadius: BorderRadius.circular(15)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  locationData!.country!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  locationData!.regionName!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Container(
            width: 200,
            height: 50,
            decoration: BoxDecoration(
                color: Colors.cyan.shade900,
                borderRadius: BorderRadius.circular(15)),
            child: Center(
              child: Text(
                "IP :  ${locationData!.query!}",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            width: 200,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.tealAccent.shade700,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Latitude :  ${locationData!.lat.toString()}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Longitude :  ${locationData!.lon.toString()}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          OutlinedButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => const Screen2()));
            },
            child: Text("See more"),
          )
        ],
      ),
    );
  }
}
