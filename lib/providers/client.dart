import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:oxidized/oxidized.dart';
import 'package:project_shelf/database/database.dart';
import 'package:project_shelf/lib/custom_form.dart';
import 'package:project_shelf/lib/form_entry.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'client.g.dart';

class ClientDto with CustomForm {
  ClientDto() {
    form = {
      "name": FormEntry(
        validator: FormBuilderValidators.compose([
          FormBuilderValidators.required(),
        ]),
      ),
      "value": FormEntry(
        validator: FormBuilderValidators.compose([
          FormBuilderValidators.min(0, checkNullOrEmpty: false),
        ]),
      ),
      "stock": FormEntry(
        validator: FormBuilderValidators.compose([
          FormBuilderValidators.min(0, checkNullOrEmpty: false),
        ]),
      ),
      "code": FormEntry(),
    };
  }
}

@riverpod
class Client extends _$Client with Validated<ClientDto, ClientData> {
  @override
  ({ClientDto dto, Option<ClientData> product}) build({
    ClientData? product,
  }) {
    return (
      dto: ClientDto(),
      product: Option.from(product),
    );
  }

  Future<void> save() async {}
}
