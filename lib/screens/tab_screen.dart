import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../widgets/main_drawer.dart';
import '../screens/category_screen.dart';
import '../screens/favourite_screen.dart';

class TabScreen extends StatefulWidget {
  static const routeName = "TabScreen";
  final List<Meal> favouriteMeal;
  TabScreen(this.favouriteMeal);
  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  List<Map<String, Object>> _pages = [];
  int _selectedPageIndex = 0;
  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  void initState() {
    _pages = [
      {"page": CategoryScreen(), 'title': "Categories"},
      {"page": FavouriteScreen(widget.favouriteMeal), 'title': "Favourite"},
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_selectedPageIndex]['title']),
      ),
      drawer: MainDrawer(),
      body: _pages[_selectedPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).accentColor,
        currentIndex: _selectedPageIndex,
        //type: BottomNavigationBarType.shifting,
        items: [
          BottomNavigationBarItem(
            //backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.category),
            label: "Categories",
          ),
          BottomNavigationBarItem(
            //backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.star),
            label: "Favourites",
          ),
        ],
      ),
    );
  }
}
