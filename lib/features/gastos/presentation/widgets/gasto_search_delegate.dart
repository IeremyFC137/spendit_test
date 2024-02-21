import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:spendit_test/features/gastos/presentation/widgets/widgets.dart';

import '../providers/providers.dart';

class GastosSearchDelegate extends SearchDelegate {
  final ThemeData theme;

  GastosSearchDelegate({required this.theme});
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = ''; // Limpiar la búsqueda
        },
      ),
    ];
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return theme.copyWith(
        scaffoldBackgroundColor:
            colors.inversePrimary.withAlpha(205).withOpacity(1),
        inputDecorationTheme: InputDecorationTheme(
          border: InputBorder.none,
          hintStyle: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w300, color: Colors.white),
          labelStyle: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w300, color: Colors.white),
        ));
  }

  @override
  TextStyle? get searchFieldStyle {
    return TextStyle(
        fontSize: 20, fontWeight: FontWeight.w300, color: Colors.white);
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null); // Cierra la barra de búsqueda
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final container = ProviderScope.containerOf(context);
    final gastosState = container.read(gastosProvider);

    // Filtrar la lista de gastos
    final resultados = gastosState.gastos.where((gasto) {
      // Verificar si el proveedor del gasto contiene la consulta
      bool proveedorMatch =
          gasto.proveedor.toLowerCase().contains(query.toLowerCase());

      // Verificar si algún detalle del gasto contiene la consulta en cCosto, cGasto, o cContable
      bool detallesMatch = gasto.detalles.any((detalle) =>
          detalle.cCosto.toLowerCase().contains(query.toLowerCase()) ||
          detalle.cGasto.toLowerCase().contains(query.toLowerCase()) ||
          detalle.cContable.toLowerCase().contains(query.toLowerCase()));

      return proveedorMatch || detallesMatch;
    }).toList();

    // Devolver la lista filtrada
    return ListView.builder(
      itemCount: resultados.length,
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        final gasto = resultados[index];
        return Dismissible(
          key: Key(gasto.id.toString()), // Asegúrate de que gasto.id sea único
          background: Container(
            color: Colors.red,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 20),
            child: Icon(Icons.delete, color: Colors.white),
          ),
          direction: DismissDirection
              .endToStart, // Permite deslizar solo hacia la izquierda
          confirmDismiss: (direction) async {
            // Muestra un diálogo de confirmación
            return await showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text("Confirmar"),
                  content: const Text(
                      "¿Estás seguro de que quieres eliminar este gasto?"),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      child: const Text("Eliminar"),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: const Text("Cancelar"),
                    ),
                  ],
                );
              },
            );
          },
          onDismissed: (direction) async {
            await container
                .read(gastosProvider.notifier)
                .eliminarGasto(gasto.id);
            showResults(context);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Card(
              color: Colors.transparent,
              elevation: 0,
              child: GestureDetector(
                  onTap: () => context.push('/gastos/${gasto.id}'),
                  child: GastoCard(gasto: gasto)),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}
