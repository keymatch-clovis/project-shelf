import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_shelf/provider.dart';
import 'package:project_shelf/shared/constants.dart';
import 'package:project_shelf/ui/components/loader.dart';

class DebugLoadDataView extends ConsumerWidget {
  const DebugLoadDataView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncValue = ref.watch(debugLoadDataViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Productos', style: TEXT_RED_800.merge(FONT_BOLD)),
      ),
      body: Loader(
        asyncValue: asyncValue,
        handler: (model) => Column(
          children: [
            ElevatedButton(
              onPressed: model.seedProducts,
              child: Text("Load test products"),
            ),
            ElevatedButton(
              onPressed: model.deleteAllProducts,
              child: Text("Delete all products"),
            ),
          ],
        ),
      ),
    );
  }
}
