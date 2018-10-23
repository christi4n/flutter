import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'model/Pizza.dart';
import 'view/PizzaCard.dart';

// import http package for JSON endpoint API
import 'package:http/http.dart' as http;

final String apiUrl = "http://lucidlab.fr/tmp/flutter/pizzas/pizzas.json";

List<Pizza> decodePizzas(String responseBody) {
  final parsedData = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsedData.map<Pizza>((json) => Pizza.fromJson(json)).toList();
}

Future<List<Pizza>> fetchPizzas(http.Client client) async {
      
      final response = await client.get(apiUrl);

      if (response.statusCode == 200) {
        return decodePizzas(response.body);
      } else {
        throw Exception('Failed to load pizza');
      }
    }

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false, // remove the demo red banner
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  

  int photoIndex = 0;

  // data about the place
  var openingHours = 'Ouvert jusqu\'a 22h';
  var placeName = 'Pizza Gigi';
  var placeAddress = '29 av. d\'Italie, 34000 Montpellier';
  double distance = 0.650;
  var extra = 'Pizzas à partir de 8.50 €';

  List<String> photos = [
    'assets/pizza-1.jpg', 
    'assets/pizza-2.jpg', 
    'assets/pizza-3.jpg'
  ];

  void _previousImage() {
    setState(() { // setState method let you notify the framework that the internal state of this object has changed
      photoIndex = photoIndex > 0 ? photoIndex - 1 : 0;
    });
  }

  Future<String> makeRequest() async {
    var response = await http
        .get(Uri.encodeFull(apiUrl), headers: {"Accept": "application/json"});
        
         return(response.body);
 
  }

  void _nextImage() {
    setState(() {
      photoIndex = photoIndex < photos.length - 1 ? photoIndex + 1 : photoIndex;
    });
  }
  

  @override
  Widget build(BuildContext context) { // This method is rerun every time setState is called

    return new Scaffold(
      body: ListView( // See ListView class - https://docs.flutter.io/flutter/widgets/ListView-class.html
        shrinkWrap: true, // the scroll view is determined by the content being views. Default is false.
        // padding: const EdgeInsets.all(20.0),
        children: <Widget>[
          Column( // A widget that displays its children in a vertical array.
            children: <Widget>[
              Stack( // A widget that positions its children relative to the edges of its box.
                children: <Widget>[
                  Container( // widget that combines common painting, positioning, and sizing widgets.
                    height: 210.0,
                    decoration: new BoxDecoration(
                    image: new DecorationImage(
                      image: new ExactAssetImage(photos[photoIndex]),
                      fit: BoxFit.cover,
                    ),
                  ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconButton( // arrow
                        icon: Icon(Icons.arrow_back),
                        color: Colors.white,
                        onPressed: () {}
                      ),
                      IconButton(
                        icon: Icon(Icons.favorite),
                        color: Colors.pink,
                        onPressed: () {}
                      )
                    ]
                  ),
                  GestureDetector( // widget that detects gestures
                    child: Container(
                      height: 210.0, // same as image container
                      width: MediaQuery.of(context).size.width,
                      color: Colors.transparent
                    ),
                    onTap: _nextImage,
                  ),
                  GestureDetector( // widget that detects gestures
                    child: Container(
                      height: 210.0, // same as image container
                      width: MediaQuery.of(context).size.width/2,
                      color: Colors.transparent
                    ),
                    onTap: _previousImage,
                  ),
                  Positioned(
                    top: 180.0,
                    left: 5.0,
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.star,
                          color: Colors.amber
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.amber
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.amber
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.amber
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.grey
                        ),
                        SizedBox(width: 2.0),
                          Text(
                            '4.0', style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        SizedBox(width: 40.0),
                        SelectedPhoto(numberOfDots: photos.length, photoIndex: photoIndex)
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: 15.0),
              Container(
                padding: EdgeInsets.only(left: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start, // How the children should be placed along the cross axis
                  children: <Widget>[
                    Text(
                      openingHours . toUpperCase(),
                      style: TextStyle(
                        color: Colors.grey,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold
                      )
                    ),
                    SizedBox(height: 15.0),
                    Text(
                      placeName,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 27.0,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          placeAddress . toUpperCase(),
                          style: TextStyle(
                            color: Colors.grey,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold
                          )
                        ),
                        SizedBox(width: 5.0),
                        Icon(
                          Icons.location_on,
                          color: Colors.black.withOpacity(0.5),
                        ),
                        SizedBox(width: 5.0),
                        Text(
                          distance.toString() + ' km(s)',
                          style: TextStyle(
                              color: Colors.black.withOpacity(0.5),
                              fontWeight: FontWeight.bold),
                        )
                       ],
                       ),
                       SizedBox(height: 8.0),
                       Row(
                         children: <Widget>[
                           Icon(
                             Icons.whatshot,
                             color: Colors.orange
                           ),
                           SizedBox(height: 4.0,),
                           Text(
                            extra,
                            style: TextStyle(
                              color: Colors.orange,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold
                              ),
                            )
                         ],
                         )
                  ]
                )
              ),
              SizedBox(height: 20.0),
              Container(
                padding: EdgeInsets.only(left: 20.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      'La carte'.toUpperCase(),
                      style: TextStyle(
                          color: Colors.grey,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold
                          ),
                    )
                  ]                                                                                                                                                                                                                                                                
                ),
              ),
              Container(
                height: 500.0,
                child: new FutureBuilder<List<Pizza>>(
                future: fetchPizzas(http.Client()),
                builder: (context, snapshot) {

                  if (snapshot.hasError) print(snapshot.error);

                  return snapshot.hasData 
                  ? new PizzasList(snapshot.data) 
                  : Center(child: CircularProgressIndicator());
                },
              )
              ),
              // SizedBox(height: 10.0),
              // _buildListItem(photos[0], pizzas[0], descriptions[0], tarifs[0]),
              // SizedBox(height: 10.0),

              // SizedBox(height: 10.0),
              // _buildListItem(photos[3]),
          ],
          )
        ],
      )
    );
  }

}

// Display here the selected photo and the dots
class SelectedPhoto extends StatelessWidget {
  final int numberOfDots;
  final int photoIndex;

  SelectedPhoto({this.numberOfDots, this.photoIndex});

  Widget _inactivePhoto() {
    return new Container(
        child: new Padding(
      padding: const EdgeInsets.only(left: 3.0, right: 3.0),
      child: Container(
        height: 8.0,
        width: 8.0,
        decoration: BoxDecoration(
            color: Colors.grey, borderRadius: BorderRadius.circular(4.0)),
      ),
    ));
  }

  Widget _activePhoto() {
    return Container(
      child: Padding(
        padding: EdgeInsets.only(left: 3.0, right: 3.0),
        child: Container(
          height: 10.0,
          width: 10.0,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey, spreadRadius: 0.0, blurRadius: 2.0)
              ]),
        ),
      ),
    );
  }

  List<Widget> _buildDots() {
    List<Widget> dots = [];

    for (int i = 0; i < numberOfDots; ++i) {
      dots.add(i == photoIndex ? _activePhoto() : _inactivePhoto());
    }

    return dots;
  }

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _buildDots(),
      ),
    );
  }

}

class PizzasList extends StatelessWidget {

  final List<dynamic> pizzas;

  PizzasList(this.pizzas);

  @override
  Widget build(BuildContext context) {
    return _buildList(context);
  }

  ListView _buildList(context) {
    return new ListView.builder(
      // Must have an item count equal to the number of items!
      itemCount: pizzas.length,
      // A callback that will return a widget.
      itemBuilder: (context, index) {
        return new PizzaCard(pizzas[index]);
      },
    );
  }

}