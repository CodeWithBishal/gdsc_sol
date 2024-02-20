import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class ArCorePage extends StatefulWidget {
  const ArCorePage({super.key});

  @override
  State<ArCorePage> createState() => _ArCorePageState();
}

class _ArCorePageState extends State<ArCorePage> {
  late ArCoreController? arCoreController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          ArCoreView(
            onArCoreViewCreated: _onArCoreViewCreated,
            // type: ArCoreViewType.AUGMENTEDIMAGES,
          ),
          // Align(
          //   alignment: Alignment.topLeft,
          //   child: ListObjectSelection(
          //     onTap: (value) {
          //       objectSelected = value;
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }

  void _onArCoreViewCreated(ArCoreController controller) {
    arCoreController = controller;

    _addSphere();
    _addCylindre();
    _addCube();
  }

  Future _addSphere() async {
    final ByteData textureBytes = await rootBundle.load('asset/obj/e.jpg');

    final material = ArCoreMaterial(
        color: const Color.fromARGB(120, 66, 134, 244),
        textureBytes: textureBytes.buffer.asUint8List());
    final sphere = ArCoreSphere(
      materials: [material],
      radius: 0.1,
    );
    final node = ArCoreNode(
      shape: sphere,
      position: vector.Vector3(0, 0, -1.5),
    );
    arCoreController?.addArCoreNode(node);
  }

  void _addCylindre() {
    final material = ArCoreMaterial(
      color: Colors.red,
      reflectance: 1.0,
    );
    final cylindre = ArCoreCylinder(
      materials: [material],
      radius: 0.5,
      height: 0.3,
    );
    final node = ArCoreNode(
      shape: cylindre,
      position: vector.Vector3(0.0, -0.5, -2.0),
    );
    arCoreController?.addArCoreNode(node);
  }

  void _addCube() {
    final material = ArCoreMaterial(
      color: const Color.fromARGB(120, 66, 134, 244),
      metallic: 1.0,
    );
    final cube = ArCoreCube(
      materials: [material],
      size: vector.Vector3(0.5, 0.5, 0.5),
    );
    final node = ArCoreNode(
      shape: cube,
      position: vector.Vector3(-0.5, 0.5, -3.5),
    );
    arCoreController?.addArCoreNode(node);
  }

  @override
  void dispose() {
    arCoreController?.dispose();
    super.dispose();
  }
}
