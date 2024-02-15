import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

class LoadingDots extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        // Primer punto
        Bounce(
          delay: Duration(milliseconds: 0), // Inicia inmediatamente
          from: 5,
          child: _buildDot(),
          infinite: true, // Hace que la animación se repita infinitamente
        ),
        // Segundo punto
        Bounce(
          delay: Duration(
              milliseconds:
                  300), // Retraso para iniciar después del primer punto
          from: 5,
          child: _buildDot(),
          infinite: true, // Hace que la animación se repita infinitamente
        ),
        // Tercer punto
        Bounce(
          delay: Duration(
              milliseconds:
                  700), // Retraso para iniciar después del segundo punto
          from: 5,
          child: _buildDot(),
          infinite: true, // Hace que la animación se repita infinitamente
        ),
      ],
    );
  }

  Widget _buildDot() {
    return Container(
      height: 12.0,
      width: 12.0,
      margin: EdgeInsets.symmetric(horizontal: 2.0),
      decoration: BoxDecoration(
        color: Colors.white12,
        shape: BoxShape.circle,
      ),
    );
  }
}
