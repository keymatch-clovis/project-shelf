import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:project_shelf/database/database.dart';
import 'package:project_shelf/providers/cities.dart';
import 'package:project_shelf/providers/city_search.dart';

final cityProvider = FutureProvider.family<CityData?, int?>((ref, rowId) {
  if (rowId != null) {
    return ref.watch(citiesProvider.selectAsync(
        (cities) => cities.firstWhere((city) => city.rowId == rowId)));
  }
  return null;
});

class CitySelector extends ConsumerWidget {
  final Function(int) onTap;

  final bool isRequired;
  final int? cityRowId;
  final Widget? icon;

  const CitySelector({
    super.key,
    required this.onTap,
    this.isRequired = false,
    this.cityRowId,
    this.icon,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = SearchController();
    final inputController = TextEditingController();
    final city = ref.watch(cityProvider(cityRowId));

    if (city.valueOrNull != null) {
      inputController.text = "${city.value!.city}, ${city.value!.department}";
    }

    Widget renderLabel() {
      final List<Widget> children = [];

      if (isRequired) {
        children.add(
          FaIcon(
            size: 14,
            color: Theme.of(context).primaryColor,
            FontAwesomeIcons.asterisk,
          ),
        );
        children.add(SizedBox(width: 4));
      }

      children.add(Text("Ciudad"));

      return Row(
        mainAxisSize: MainAxisSize.min,
        children: children,
      );
    }

    Widget renderList(List<CityData> list) {
      return ListView.builder(
        // See more:
        // https://stackoverflow.com/questions/63639472/flutter-unexpected-space-at-the-top-of-listview
        padding: EdgeInsets.only(top: 0),
        itemCount: list.length,
        itemBuilder: (_, index) => ListTile(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                list[index].department,
                style: TextStyle(fontSize: 10),
              ),
              Text(list[index].city),
            ],
          ),
          onTap: () {
            onTap(list[index].rowId);
            controller.closeView(null);
          },
        ),
      );
    }

    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: SearchAnchor(
        searchController: controller,
        builder: (context, controller) => Stack(
          alignment: AlignmentDirectional.center,
          children: [
            TextFormField(
              controller: inputController,
              decoration: InputDecoration(
                label: renderLabel(),
                border: OutlineInputBorder(),
                icon: icon,
                hintText: "Ciudad",
              ),
              onTap: () => controller.openView(),
              readOnly: true,
            ),
            if (city.isLoading)
              Center(child: CircularProgressIndicator.adaptive()),
          ],
        ),
        suggestionsBuilder: (_, controller) {
          ref.read(citySearchProvider.notifier).setSearch(controller.text);
          return [];
        },
        viewBuilder: (_) => Consumer(
          builder: (_, ref, __) {
            return switch (ref.watch(citySearchProvider)) {
              AsyncData(:final value) => renderList(value),
              _ => Center(child: const CircularProgressIndicator.adaptive()),
            };
          },
        ),
      ),
    );
  }
}
