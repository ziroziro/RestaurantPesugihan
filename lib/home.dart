import 'package:flutter/material.dart';
import 'package:restaurant_ziro/service.dart';

import 'data.dart';
import 'detail.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController editingController = TextEditingController();

  List<Restaurant> searchItems = [];
  List<Restaurant> items = [];

  @override
  void initState() {
    Service.getRestaurant().then((list) {
      setState(() {
        items = list.restaurants;
        searchItems = items;
      });
    });
    super.initState();
  }

  void filterSearchResults(String query) {
    List<Restaurant> resultList = [];
    if (query.isEmpty) {
      resultList = items;
    } else {
      resultList = items
          .where((thisisit) =>
              thisisit.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    setState(() {
      searchItems = resultList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          elevation: 6,
          title: const Text(
            "Find My Restaurant",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: TextField(
                onChanged: (value) {
                  filterSearchResults(value);
                },
                controller: editingController,
                decoration: const InputDecoration(
                    hintText: "Search by Name",
                    prefixIcon: Icon(Icons.search),
                    contentPadding: EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 12.0),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.all(Radius.circular(32.0)))),
              ),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: searchItems.length,
                  itemBuilder: (BuildContext context, int index) {
                    Restaurant restaurant = searchItems[index];
                    return GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => DetailPage(
                                    name: restaurant.name,
                                    description: restaurant.description,
                                    pictureId: restaurant.pictureId,
                                    city: restaurant.city,
                                    rating: restaurant.rating,
                                    foods: restaurant.menus.foods,
                                    drink: restaurant.menus.drinks,
                                  ))),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 3),
                        child: Card(
                          elevation: 3,
                          key: ValueKey(restaurant.id),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.all(10),
                                width: 120,
                                height: 80,
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10.0)),
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                            restaurant.pictureId))),
                              ),
                              Expanded(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        restaurant.name,
                                        style: const TextStyle(
                                          color: Colors.red,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        overflow: TextOverflow.visible,
                                        maxLines: 2,
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.location_on,
                                            color: Colors.amber,
                                            size: 20.0,
                                          ),
                                          const SizedBox(width: 3),
                                          Text(
                                            restaurant.city,
                                            style:
                                                const TextStyle(fontSize: 12),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                            size: 20.0,
                                          ),
                                          const SizedBox(width: 3),
                                          Text(
                                            restaurant.rating.toString(),
                                            style: const TextStyle(
                                              color: Colors.amber,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ));
  }
}
