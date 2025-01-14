import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipes_app/providers/meal_provider.dart';
import '../dummy_data.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class MealDetailsScreen extends StatelessWidget {
  static final routName = '/MealDetailsScreen';
  Widget title(BuildContext context, String title) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      alignment: Alignment.center,
      child: Text(title, style: Theme.of(context).textTheme.headline6),
    );
  }

  Widget list(Widget child) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(width: 1, color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      height: 150,
      width: 300,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final routeArg = ModalRoute.of(context)?.settings.arguments as Map;

    final selectedMeal =
        DUMMY_MEALS.firstWhere((meal) => meal.id == routeArg['id']);

    var accentColor = Theme.of(context).accentColor;

    return Scaffold(
      appBar: AppBar(
        title: Text(routeArg['title']),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 300,
              child: Image.asset('${selectedMeal.imageUrl}', fit: BoxFit.cover),
            ),
            title(context, 'ingredients'),
            list(ListView.builder(
              itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: Card(
                  color: accentColor,
                  child: Text(
                    '${routeArg["ingredients"][index]}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      color: useWhiteForeground(accentColor)
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                ),
              ),
              itemCount: routeArg["ingredients"].length,
            )),
            title(context, 'step'),
            list(ListView.builder(
              itemBuilder: (context, index) => Column(
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      child: Text('#${index + 1}'),
                    ),
                    title: Text(
                      '${routeArg["steps"][index]}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Divider(),
                ],
              ),
              itemCount: routeArg["steps"].length,
            )),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Provider.of<MealProvider>(
          context,
          listen: false,
        ).toggleFavorite(routeArg['id']),
        child: Icon(
          Provider.of<MealProvider>(
            context,
            listen: true,
          ).isFavorite(routeArg['id'])
              ? Icons.star
              : Icons.star_border,
        ),
      ),
    );
  }
}
