import 'package:flutter/material.dart';
import 'package:meal_choice/widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = "FiltersScreen";
  final Function saveFilters;
  final Map<String, bool> filters;
  FiltersScreen(this.saveFilters, this.filters);

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _glutenFree = false;
  bool _vegetarian = false;
  bool _vegan = false;
  bool _lactoseFree = false;

  @override
  void initState() {
    _glutenFree = widget.filters['gluten'];
    _vegetarian = widget.filters['vegetarian'];
    _vegan = widget.filters['vegan'];
    _lactoseFree = widget.filters['lactose'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Filters"),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              final _selectedFilters = {
                "gluten": _glutenFree,
                "vegetarian": _vegetarian,
                "vegan": _vegan,
                "lactose": _lactoseFree,
              };
              widget.saveFilters(_selectedFilters);
            },
          ),
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              "Adjust your meal selection",
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                buildSwitchListTile(
                  _glutenFree,
                  "Gluten Free",
                  "only include gluten free meals",
                  (value) {
                    setState(() {
                      _glutenFree = value;
                    });
                  },
                ),
                buildSwitchListTile(
                  _vegetarian,
                  "Vegetarian",
                  "only include Vegetarian meals",
                  (value) {
                    setState(() {
                      _vegetarian = value;
                    });
                  },
                ),
                buildSwitchListTile(
                  _vegan,
                  "Vegan",
                  "only include Vegan meals",
                  (value) {
                    setState(() {
                      _vegan = value;
                    });
                  },
                ),
                buildSwitchListTile(
                  _lactoseFree,
                  "Lactose-Free",
                  "only include Lactose-Free meals",
                  (value) {
                    setState(() {
                      _lactoseFree = value;
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  SwitchListTile buildSwitchListTile(
      bool currentValue, String label, String subLabel, Function updatevalue) {
    return SwitchListTile(
      value: currentValue,
      title: Text(label),
      subtitle: Text(subLabel),
      onChanged: updatevalue,
    );
  }
}
