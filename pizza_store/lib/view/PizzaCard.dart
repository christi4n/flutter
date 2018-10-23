import 'package:flutter/material.dart';
import '../model/Pizza.dart';

class PizzaCard extends StatefulWidget {
  final Pizza pizza;

  PizzaCard(this.pizza);

  @override
  _PizzaCardState createState() => new _PizzaCardState(pizza);
}

class _PizzaCardState extends State<PizzaCard> {
   Pizza pizza;

   _PizzaCardState(this.pizza);

   Widget get pizzaCard {
     return new Column(
       crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 100.0,
              width: 100.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(widget.pizza.imageUrl),
                  fit: BoxFit.cover
                ),
                borderRadius: BorderRadius.only(topRight: Radius.circular(10.0), bottomRight: Radius.circular(10.0))
              ),
            ),
            SizedBox(width: 10.0),
            Container(
              height: 100.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                            Text(widget.pizza.title,
                            style: TextStyle(
                              fontSize: 15.0,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold
                            ),
                            ),
                            SizedBox(height: 5.0),
                            Text(widget.pizza.composition,
                            style: TextStyle(
                              fontSize: 11.0,
                              fontFamily: 'Montserrat',
                              // fontWeight: FontWeight.bold,
                              color: Colors.grey
                            ),
                            ),
                            Text('et autres ingrédients',
                            style: TextStyle(
                              fontSize: 11.0,
                              fontFamily: 'Montserrat',
                              // fontWeight: FontWeight.bold,
                              color: Colors.grey
                            ),),
                            SizedBox(height: 10.0),
                            Text(widget.pizza.price + ' €',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey
                            ),)
                          ],
              ),
            )
          ],
        )
      ],
      );
   }

  @override
  Widget build(BuildContext context) {
    return pizzaCard;
  }
}