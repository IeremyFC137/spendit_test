import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:spendit_test/features/gastos/domain/domain.dart';

class GastoCard extends StatelessWidget {
  final Gasto gasto;

  const GastoCard({super.key, required this.gasto});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SvgPicture.asset(
        'assets/img/image.svg',
        width: 50.0,
        height: 50.0,
      ),
      title:
          Text(gasto.proveedor, style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(gasto.cCosto,
              style: TextStyle(color: Colors.black.withOpacity(0.6))),
          Text(DateFormat('yyyy-MM-dd').format(gasto.fechaEmision).toString(),
              style: TextStyle(color: Colors.black.withOpacity(0.6)))
        ],
      ),
      trailing: FittedBox(
        fit: BoxFit.fill,
        child: Column(
          children: <Widget>[
            Text(
              ((gasto.igv + gasto.subTotal).toString()) +
                  "${gasto.moneda == Moneda.SOLES ? " PEN" : " USD"}",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(gasto.estado,
                    style: TextStyle(color: Colors.black.withOpacity(0.6))),
                Icon(Icons.edit, color: Colors.orange)
              ],
            )
          ],
        ),
      ),
    );
  }
}
