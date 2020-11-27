import 'package:flutter/material.dart';
//import 'package:meal_choice/screens/category_screen.dart';
import 'package:meal_choice/screens/filters_screen.dart';
import 'package:meal_choice/screens/tab_screen.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 120,
            width: double.infinity,
            padding: EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            color: Theme.of(context).accentColor,
            child: Text(
              'At The Table!!!',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 30,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          SizedBox(height: 20),
          buildListTileOptions(
              label: "Meals",
              icons: Icons.restaurant,
              tapHandler: () =>
                  Navigator.pushReplacementNamed(context, TabScreen.routeName)),
          buildListTileOptions(
              label: "Filters",
              icons: Icons.settings,
              tapHandler: () => Navigator.pushReplacementNamed(
                  context, FiltersScreen.routeName)),
        ],
      ),
    );
  }

  ListTile buildListTileOptions(
      {String label, IconData icons, Function tapHandler}) {
    return ListTile(
      onTap: tapHandler,
      leading: Icon(
        icons,
        size: 26,
      ),
      title: Text(
        label,
        style: TextStyle(
          fontFamily: "RobotoCondensed",
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
