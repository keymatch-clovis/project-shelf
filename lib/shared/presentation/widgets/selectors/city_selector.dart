import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:project_shelf/data/repository/cities_repository.dart';
import 'package:project_shelf/database/database.dart';
import 'package:project_shelf/providers/city_search.dart';

final cityProvider = FutureProvider.family<CityData?, int?>((ref, rowId) {
  if (rowId != null) {
    return ref.watch(citiesRepositoryProvider.selectAsync((cities) {
      return cities.firstWhere((city) => city.id == rowId);
    }));
  }
  return null;
});

class CitySelector extends HookConsumerWidget {
  final Function(int)? onTap;
  final bool isRequired;
  final bool readOnly;
  final int? cityRowId;
  final Widget? icon;

  const CitySelector({
    super.key,
    this.onTap,
    this.isRequired = false,
    this.readOnly = false,
    this.cityRowId,
    this.icon,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useSearchController();
    final inputController = useTextEditingController();
    final city = ref.watch(cityProvider(cityRowId));

    useEffect(() {
      city.whenData((c) {
        if (c != null) {
          // We have to register this in a post frame callback, as the city can
          // change before the widget has finished building.
          WidgetsBinding.instance.addPostFrameCallback((_) {
            inputController.text = "${c.city}, ${c.department}";
          });
        }
      });
      return null;
    }, [city]);

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
      return ListView.separated(
        // See more:
        // https://stackoverflow.com/questions/63639472/flutter-unexpected-space-at-the-top-of-listview
        padding: EdgeInsets.only(top: 0),
        separatorBuilder: (_, __) => Divider(),
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
            controller.closeView(null);
            onTap!(list[index].id);
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
              validator: isRequired ? FormBuilderValidators.required() : null,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: inputController,
              decoration: InputDecoration(
                label: renderLabel(),
                border: OutlineInputBorder(),
                icon: icon,
                hintText: "Ciudad",
              ),
              onTap: () {
                if (readOnly) {
                  return;
                }

                controller.openView();
              },
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
