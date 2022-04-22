import 'package:flutter/material.dart';
import 'dart:math' as Math;

class AnimacionPage extends StatelessWidget {
  const AnimacionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CuadradoAnimado(),
      ),
    );
  }
}

class CuadradoAnimado extends StatefulWidget {
  const CuadradoAnimado({
    Key? key,
  }) : super(key: key);

  @override
  State<CuadradoAnimado> createState() => _CuadradoAnimadoState();
}

class _CuadradoAnimadoState extends State<CuadradoAnimado>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  late Animation<double> rotation;
  late Animation<double> opacity;
  late Animation<double> opacityOut;
  late Animation<double> moveDerecha;
  late Animation<double> scale;

  @override
  void initState() {
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 4000));

    rotation = Tween(begin: 0.0, end: 1.0 * Math.pi).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeInOutQuart));
    controller.addListener(() {});
    opacity = Tween(begin: 0.1, end: 1.0).animate(CurvedAnimation(
        parent: controller,
        curve: const Interval(0, 0.25, curve: Curves.easeInCubic)));
    moveDerecha = Tween(begin: 0.0, end: 150.0).animate(
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn));
    scale = Tween(begin: 0.0, end: 1.0).animate(controller);
    opacityOut = Tween(begin: 1.0, end: 0.0).animate(
        CurvedAnimation(parent: controller, curve: const Interval(0.75, 1.0)));
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    controller.forward();
    return AnimatedBuilder(
      animation: controller,
      //child: Rectangulo(),
      builder: (_, Widget? child) {
        print("opacity: ${opacity.status}");
        return Transform.translate(
          offset: Offset(moveDerecha.value, 0),
          child: Transform.rotate(
              angle: rotation.value,
              child: Opacity(
                  opacity: opacity.value,
                  child: Opacity(
                    opacity: opacityOut.value,
                    child: Transform.scale(
                        scale: scale.value, child: _Rectangulo()),
                  ))),
        );
      },
    );
  }
}

class _Rectangulo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(color: Colors.blue[200]),
    );
  }
}
