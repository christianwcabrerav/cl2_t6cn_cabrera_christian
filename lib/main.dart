import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.yellow,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Office Food'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  String nombres;
  String pedidos;
  double precio;
  int cantidad;

  double total = 0;
  // ignore: non_constant_identifier_names
  double pago_total = 0;
  //bool delivery;
  double descuento = 0;
  String mensaje = "";
  bool validacion = false;

  @override
  MenuOffice createState() => MenuOffice();
}

class MenuOffice extends State<MyHomePage> {
  bool val = true;
  final _tfNombres = TextEditingController();
  final _tfPedidos = TextEditingController();
  final _tfPrecio = TextEditingController();
  final _tfCantidad = TextEditingController();

  void someting(bool delivery) {
    setState(() {
      if (delivery) {
        val = true;
        delivery = true;
        widget.pago_total = (widget.total + 20) - widget.descuento;
      } else {
        val = false;
        delivery = false;
        widget.pago_total = widget.total - widget.descuento;
      }
    });
  }

  void _calcularTotal() {
    setState(() {
      widget.validacion = false;
      if (_tfPrecio.text.toString() == "" ||
          _tfCantidad.text.toString() == "") {
        widget.validacion = true;
        widget.mensaje = "FALTAN DATOS";
        return;
      }

      widget.precio = double.parse(_tfPrecio.text);
      widget.cantidad = int.parse(_tfCantidad.text);
      widget.total = (widget.precio * widget.cantidad);
      widget.pago_total = widget.total - widget.descuento;

      if (widget.total >= 500) {
        widget.descuento = (widget.total * 0.05);
      } else {
        widget.descuento = 0.0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: ListView(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              child: Text("Bienvenido, ingrese sus datos para reservar pedido"),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: Column(
                children: <Widget>[
                  TextField(
                      controller: _tfNombres,
                      decoration: InputDecoration(
                        hintText: "Ingrese Nombre",
                        labelText: "Nombres",
                      )),
                  TextField(
                      controller: _tfPedidos,
                      decoration: InputDecoration(
                        hintText: "Ingrese Pedido",
                        labelText: "Pedido",
                      )),
                  TextField(
                      controller: _tfPrecio,
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      decoration: InputDecoration(
                        hintText: "Ingrese Precio",
                        labelText: "Precio",
                        errorText: _tfPrecio.text.toString() == ""
                            ? widget.mensaje
                            : null,
                      )),
                  TextField(
                      controller: _tfCantidad,
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      decoration: InputDecoration(
                        hintText: "Ingrese Cantidad",
                        labelText: "Cantidad",
                        errorText: _tfCantidad.text.toString() == ""
                            ? widget.mensaje
                            : null,
                      )),
                  Text("Total :" + widget.total.toString()),
                  Text("Descuento :" + widget.descuento.toString()),
                  Text("Delivery "),
                  new Switch(
                    value: val,
                    onChanged: (bool delivery) => someting(delivery),
                    activeColor: Colors.lightGreenAccent,
                  ),
                  Text("Pago Total :" + widget.pago_total.toString()),
                  RaisedButton(
                    color: Colors.yellow,
                    child: Text(
                      "Calcular",
                      style: TextStyle(fontSize: 18, fontFamily: "rbold"),
                    ),
                    onPressed: _calcularTotal,
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
