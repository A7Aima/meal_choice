import 'package:flutter/material.dart';
import 'package:meal_choice/data/dummy_data.dart';
import 'package:meal_choice/screens/filters_screen.dart';
import 'package:meal_choice/screens/tab_screen.dart';
import './screens/category_meal_screen.dart';
import './screens/category_screen.dart';
import './screens/meal_detail_screen.dart';
import './models/meal.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    "gluten": false,
    "vegetarian": false,
    "vegan": false,
    "lactose": false,
  };
  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favouriteMeals = [];

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;
      _availableMeals = DUMMY_MEALS.where((meal) {
        if (_filters['gluten'] && !meal.isGlutenFree) {
          return false;
        }
        if (_filters['vegetarian'] && !meal.isVegetarian) {
          return false;
        }
        if (_filters['vegan'] && !meal.isVegan) {
          return false;
        }
        if (_filters['lactose'] && !meal.isLactoseFree) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _toggleFavourite(String mealId) {
    final existingIndex =
        _favouriteMeals.indexWhere((meal) => meal.id == mealId);
    if (existingIndex >= 0) {
      setState(() {
        _favouriteMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favouriteMeals
            .add(DUMMY_MEALS.firstWhere((meal) => mealId == meal.id));
      });
    }
  }

  bool _isMealFavourite(String id) {
    return _favouriteMeals.any((meal) => meal.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: "Raleway",
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
              bodyText2: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
              headline6: TextStyle(
                fontSize: 18,
                fontFamily: "RobotoCondensed",
                fontWeight: FontWeight.bold,
              ),
            ),
      ),
      initialRoute: TabScreen.routeName,
      routes: {
        TabScreen.routeName: (_) => TabScreen(_favouriteMeals),
        CategoryScreen.routeName: (_) => CategoryScreen(),
        CategoryMealScreen.routeName: (_) =>
            CategoryMealScreen(_availableMeals),
        MealDetailScreen.routeName: (_) =>
            MealDetailScreen(_toggleFavourite, _isMealFavourite),
        FiltersScreen.routeName: (_) => FiltersScreen(_setFilters, _filters),
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (_) => CategoryScreen());
      },
    );
  }
}
