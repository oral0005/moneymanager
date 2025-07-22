import 'package:flutter/material.dart';

const List<String> filterTabs = ['all', 'day', 'month', 'custom'];

class FilterTabBar extends StatelessWidget {
  final String selected;
  final ValueChanged<String> onChanged;

  const FilterTabBar({
    Key? key,
    required this.selected,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TabBar(
      isScrollable: true,
      labelColor: Theme.of(context).colorScheme.primary,
      unselectedLabelColor: Colors.grey,
      indicatorColor: Theme.of(context).colorScheme.primary,
      tabs: filterTabs
          .map((f) => Tab(text: f[0].toUpperCase() + f.substring(1)))
          .toList(),
      onTap: (index) => onChanged(filterTabs[index]),
      controller: TabController(
        length: filterTabs.length,
        vsync: Scaffold.of(context),
        initialIndex: filterTabs.indexOf(selected),
      ),
    );
  }
}