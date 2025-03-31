import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:project_shelf/shared/presentation/widgets/selectors/city_selector.dart';
import 'package:project_shelf/shared/presentation/widgets/text_fields/custom_text_field.dart';
import 'package:project_shelf/data/repository/customers_repository.dart';
import 'package:project_shelf/database/database.dart';

class CustomerView extends HookConsumerWidget {
  final CustomerData _customer;

  const CustomerView(this._customer, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final customer = useState(_customer);
    useEffect(() {
      customer.value = _customer;
      return null;
    }, [_customer]);

    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text(customer.value.name)),
      body: Container(
        margin: const EdgeInsets.all(18),
        child: Column(
          children: [
            CustomTextField(
              readOnly: true,
              label: "Nombre del Cliente",
              initialValue: customer.value.name,
            ),
            CustomTextField(
              readOnly: true,
              label: "Dirección",
              initialValue: customer.value.address,
            ),
            CitySelector(
              readOnly: true,
              cityRowId: customer.value.city,
            ),
            CustomTextField(
              readOnly: true,
              label: "Teléfono",
              initialValue: customer.value.phone,
            ),
            CustomTextField(
              readOnly: true,
              label: "Nombre del Negocio",
              initialValue: customer.value.businessName,
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: null,
            onPressed: () async {
              final result = await showDialog(
                context: context,
                builder: (context) => Dialog(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("¿Estás seguro?"),
                        ElevatedButton(
                          onPressed: () {
                            context.go("/customers");
                          },
                          child: const Text("Eliminar"),
                        )
                      ],
                    ),
                  ),
                ),
              );

              if (result != null && result) {
                await ref
                    .read(customersRepositoryProvider.notifier)
                    .delete(_customer.uuid);

                if (context.mounted) {
                  context.go("/customers");
                }
              }
            },
            child: FaIcon(FontAwesomeIcons.trashCan),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            heroTag: null,
            onPressed: () => context.go(
              "/customers/customer/edit",
              extra: _customer,
            ),
            child: FaIcon(FontAwesomeIcons.pen),
          ),
        ],
      ),
    );
  }
}
