import 'package:flutter/material.dart';
import 'package:meal_choice/models/meal.dart';
import 'package:meal_choice/widgets/meal_item.dart';

class CategoryMealScreen extends StatefulWidget {
  static const routeName = "CategoryMealScreen";
  final List<Meal> availableMeals;
  CategoryMealScreen(this.availableMeals);

  @override
  _CategoryMealScreenState createState() => _CategoryMealScreenState();
}

class _CategoryMealScreenState extends State<CategoryMealScreen> {
  String categoryTitle;
  List<Meal> displayMeal;
  bool _loadedInitData = false;
  @override
  void didChangeDependencies() {
    //print("Top $_loadedInitData");
    if (!_loadedInitData) {
      // didn't need it but just to be sure
      final routeArg =
          ModalRoute.of(context).settings.arguments as Map<String, String>;
      categoryTitle = routeArg['title'];
      final categoryId = routeArg['id'];
      displayMeal = widget.availableMeals
          .where((meal) => meal.categories.contains(categoryId))
          .toList();
      _loadedInitData = true;
      // print("Inside $_loadedInitData");
    }
    //print("Outside $_loadedInitData");
    super.didChangeDependencies();
  }

  void _removeMeal(String mealId) {
    setState(() {
      displayMeal.removeWhere((meal) => meal.id == mealId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: ListView.builder(
        itemCount: displayMeal.length,
        itemBuilder: (ctx, index) {
          return MealItem(
            id: displayMeal[index].id,
            title: displayMeal[index].title,
            imageUrl: displayMeal[index].imageUrl,
            duration: displayMeal[index].duration,
            complexity: displayMeal[index].complexity,
            affordability: displayMeal[index].affordability,
            removeItem: _removeMeal,
          );
        },
      ),
    );
  }
}
