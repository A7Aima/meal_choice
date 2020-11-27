import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../widgets/meal_item.dart';

class FavouriteScreen extends StatelessWidget {
  final List<Meal> favouriteMeal;
  FavouriteScreen(this.favouriteMeal);
  static const routeName = 'FavouriteScreen';
  @override
  Widget build(BuildContext context) {
    if (favouriteMeal.isEmpty) {
      return Center(
        child: Text("You have no favourites yet - start adding some"),
      );
    } else {
      return ListView.builder(
        itemCount: favouriteMeal.length,
        itemBuilder: (ctx, index) {
          return MealItem(
            id: favouriteMeal[index].id,
            title: favouriteMeal[index].title,
            imageUrl: favouriteMeal[index].imageUrl,
            duration: favouriteMeal[index].duration,
            complexity: favouriteMeal[index].complexity,
            affordability: favouriteMeal[index].affordability,
            //removeItem: _removeMeal,
          );
        },
      );
    }
  }
}
