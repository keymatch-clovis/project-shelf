import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:project_shelf/database/database.dart';
import 'package:project_shelf/providers/customer_search.dart';
import 'package:project_shelf/providers/customers.dart';

final customerProvider =
    FutureProvider.family<CustomerData?, String?>((ref, uuid) {
  if (uuid != null) {
    return ref
        .watch(customersProvider.selectAsync(
          (customers) =>
              customers.firstWhere((data) => data.customer.uuid == uuid),
        ))
        .then((data) => data.customer);
  }
  return null;
});

class CustomerSelector extends HookConsumerWidget {
  final Function(CustomerData)? onTap;
  final bool isRequired;
  final bool readOnly;
  final String? customerUuid;
  final Widget? icon;

  const CustomerSelector({
    super.key,
    this.onTap,
    this.isRequired = false,
    this.readOnly = false,
    this.customerUuid,
    this.icon,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useSearchController();
    final inputController = useTextEditingController();
    final customer = ref.watch(customerProvider(customerUuid));

    useEffect(() {
      customer.whenData((c) {
        if (c != null) {
          // We have to register this in a post frame callback, as the city can
          // change before the widget has finished building.
          WidgetsBinding.instance.addPostFrameCallback((_) {
            inputController.text = c.name;
          });
        }
      });
      return null;
    }, [customer]);

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

      children.add(Text("Cliente"));

      return Row(
        mainAxisSize: MainAxisSize.min,
        children: children,
      );
    }

    Widget renderList(List<CustomerData> list) {
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
                list[index].businessName ?? "Sin nombre de negocio",
                style: TextStyle(fontSize: 10),
              ),
              Text(list[index].name),
            ],
          ),
          onTap: () {
            controller.closeView(null);
            onTap!(list[index]);
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
                hintText: "Cliente",
              ),
              onTap: () {
                if (readOnly) {
                  return;
                }

                controller.openView();
              },
              readOnly: true,
            ),
            if (customer.isLoading)
              Center(child: CircularProgressIndicator.adaptive()),
          ],
        ),
        suggestionsBuilder: (_, controller) {
          ref.read(customerSearchProvider.notifier).setSearch(controller.text);
          return [];
        },
        viewBuilder: (_) => Consumer(
          builder: (_, ref, __) {
            return switch (ref.watch(customerSearchProvider)) {
              AsyncData(:final value) => renderList(
                  value.map((v) => v.customer).toList(),
                ),
              _ => Center(child: const CircularProgressIndicator.adaptive()),
            };
          },
        ),
      ),
    );
  }
}
