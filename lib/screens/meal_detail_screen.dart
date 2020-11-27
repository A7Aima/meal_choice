import 'package:flutter/material.dart';
import '../data/dummy_data.dart';
import 'package:meal_choice/models/meal.dart';

class MealDetailScreen extends StatelessWidget {
  static const routeName = "MealDetailScreen";
  final Function toggleFavourite;
  final Function isFavourite;
  MealDetailScreen(this.toggleFavourite, this.isFavourite);
  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context).settings.arguments as String;
    final selectedMeal =
        DUMMY_MEALS.firstWhere((element) => element.id == mealId);
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedMeal.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            buildImageMeal(selectedMeal),
            buildLabel(context, 'Ingredients'),
            buildListMethod(
              height: 200,
              list: ListView.builder(
                itemCount: selectedMeal.ingredients.length,
                itemBuilder: (context, index) => Card(
                  color: Theme.of(context).accentColor,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(selectedMeal.ingredients[index]),
                  ),
                ),
              ),
            ),
            buildLabel(context, 'Steps'),
            buildListMethod(
              height: 300,
              list: ListView.builder(
                itemCount: selectedMeal.steps.length,
                itemBuilder: (ctx, index) => Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        child: Text("#${index + 1}"),
                      ),
                      title: Text(selectedMeal.steps[index]),
                    ),
                    Divider(
                      height: 3,
                      thickness: 1,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: null,
            child: Icon(
              isFavourite(mealId) ? Icons.star : Icons.star_border,
            ),
            onPressed: () => toggleFavourite(mealId),
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            heroTag: null,
            child: Icon(
              Icons.delete,
            ),
            onPressed: () {
              Navigator.pop(context,
                  mealId); // pops the current page but it ensures weather the there ia an existing page
            },
          ),
        ],
      ),
    );
  }

  Container buildImageMeal(Meal selectedMeal) {
    return Container(
      height: 300,
      width: double.infinity,
      child: Image.network(
        selectedMeal.imageUrl,
        fit: BoxFit.cover,
      ),
    );
  }

  Container buildLabel(BuildContext context, String label) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        label,
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }

  Container buildListMethod({double height, Widget list}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      padding: EdgeInsets.all(10),
      height: height,
      width: double.infinity,
      child: list,
    );
  }
}
