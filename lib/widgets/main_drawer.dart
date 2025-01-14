import 'package:flutter/material.dart';
import 'package:recipes_app/screens/themes_screen.dart';
import '../screens/filters_screen.dart';
import '../screens/tabs_screen.dart';

class MainDrawer extends StatelessWidget {
  Widget tilesOfDrawer(
    IconData icon,
    String title,
    void Function()? tapHandler,
    BuildContext context,
  ) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
        color: Theme.of(context).buttonColor,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: Theme.of(context).textTheme.bodyText1!.color,
          fontSize: 24,
          fontFamily: 'RobotoCondensed',
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: tapHandler,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0,
      child: Column(
        children: <Widget>[
          Container(
            height: 120,
            width: double.infinity,
            padding: EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            color: Theme.of(context).accentColor,
            child: Text(
              'cooking up',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w900,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          SizedBox(height: 20),
          tilesOfDrawer(
            Icons.restaurant,
            'Meal',
            () =>
                Navigator.of(context).pushReplacementNamed(TabsScreen.routName),
            context,
          ),
          tilesOfDrawer(
            Icons.settings,
            'filters',
            () => Navigator.of(context)
                .pushReplacementNamed(FiltersScreen.routName),
            context,
          ),
          tilesOfDrawer(
            Icons.color_lens,
            'Themes',
            () => Navigator.of(context)
                .pushReplacementNamed(ThemesScreen.routName),
            context,
          ),
        ],
      ),
    );
  }
}
