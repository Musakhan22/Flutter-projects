import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/add_place_screen.dart';
import './place_detail_screen.dart';
import '../providers/great_places.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Places'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlacesScreen.routeName);
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<GreatPlaces>(context, listen: false)
            .fetchAndSetPlaces(),
        builder: (ctx, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<GreatPlaces>(
                child: const Center(
                  child: Text('No places available, Start Adding Some'),
                ),
                builder: (ctx, greatPlaces, ch) => greatPlaces.items.length <= 0
                    ? ch!
                    : ListView.builder(
                        itemCount: greatPlaces.items.length,
                        itemBuilder: (ctx, i) => ListTile(
                          leading: CircleAvatar(
                            backgroundImage:
                                FileImage(greatPlaces.items[i].image),
                          ),
                          title: Text(greatPlaces.items[i].title),
                          subtitle: Text(greatPlaces.items[i].location.address),
                          onTap: () {
                            Navigator.of(context).pushNamed(
                              PlaceDetailScreen.routeName,
                              arguments: greatPlaces.items[i].id,
                            );
                          },
                        ),
                      ),
              ),
      ),
    );
  }
}
