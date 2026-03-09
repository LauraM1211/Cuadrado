import 'package:flutter/material.dart';
import 'dart:math'; // Necesario para el color aleatorio

void main() => runApp(const MaterialApp(home: TallerGestos()));

class TallerGestos extends StatefulWidget {
  const TallerGestos({super.key});

  @override
  State<TallerGestos> createState() => _TallerGestosState();
}

class _TallerGestosState extends State<TallerGestos> {
  // --- VARIABLES DE ESTADO ---
  Offset _posicion = const Offset(100, 100); // Posición inicial (X, Y)
  Color _color = Colors.blue; // Color inicial
  double _size = 100.0; // Tamaño inicial

  void _cambiarColor() {
    setState(() {
      _color = Colors.primaries[Random().nextInt(Colors.primaries.length)];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Solución: Gestos en Flutter')),
      // Usamos Stack para que el cuadrado flote sobre el fondo
      body: Stack(
        children: [
          Positioned(
            left: _posicion.dx,
            top: _posicion.dy,
            child: GestureDetector(
              // 1. Toque simple: Cambia el color
              onTap: _cambiarColor,

              // 2. Doble toque: Resetea el tamaño o lo agranda
              onDoubleTap: () {
                setState(() {
                  _size = (_size == 100.0) ? 150.0 : 100.0;
                });
              },

              // 3. Arrastrar: Actualiza el Offset sumando el movimiento (delta)
              onPanUpdate: (details) {
                setState(() {
                  // Aquí sumamos el movimiento del dedo a la posición actual
                  _posicion += details.delta;
                });
              },

              child: Container(
                width: _size,
                height: _size,
                decoration: BoxDecoration(
                  color: _color,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(blurRadius: 10, color: Colors.black26),
                  ],
                ),
                child: const Center(
                  child: Text(
                    '¡Muéveme!',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
