import 'dart:typed_data';
import 'package:flutter/services.dart' show rootBundle;

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:pdf_app/fichier.dart' if (dart.library.html) 'fichierweb.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: MyHomePage(title: 'print document'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<void> _createXlsx() async {}
  Future<void> _createDocx() async {}
  Future<void> _createPdf() async {
    PdfDocument document = PdfDocument();

    final page = document.pages.add();
    //ajout du texte
    page.graphics.drawString("Welcome to PDF Succinctly!",
        PdfStandardFont(PdfFontFamily.helvetica, 30));
    //ajout de l'image
    page.graphics.drawImage(PdfBitmap(await _readImageData('pdf.jpeg')),
        const Rect.fromLTWH(0, 100, 440, 550));
    //ajout du tableau
    PdfGrid grid = PdfGrid();

    grid.style =
        PdfGridStyle(font: PdfStandardFont(PdfFontFamily.helvetica, 30),
              cellPadding: PdfPaddings(left: 5, right: 2, top: 2, bottom: 2));

    grid.columns.add(count: 3);
    grid.headers.add(1);

    PdfGridRow header = grid.headers[0];
    header.cells[0].value = 'id';
    header.cells[1].value = 'Account';
    header.cells[2].value = 'balance';

    PdfGridRow row = grid.rows.add();
    row.cells[0].value = '1';
    row.cells[1].value = '3243536';
    row.cells[2].value = '2250 \$';

    grid.rows.add();
    row.cells[0].value = '2';
    row.cells[1].value = '8709892';
    row.cells[2].value = '56278 \$';

    grid.rows.add();
    row.cells[0].value = '3';
    row.cells[1].value = '87389';
    row.cells[2].value = '24634673 \$';

    grid.draw(
        page: document.pages.add(), bounds: const Rect.fromLTWH(0, 0, 0, 0));
    List<int> bytes = await document.save();

    document.dispose();

    Fichier.saveAndLauchFile(bytes, 'output.pdf');
  }

  // methode to read image
  Future<Uint8List> _readImageData(String name) async {
    final data = await rootBundle.load('assets/images/$name');
    return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
           backgroundColor: Colors.white,
           foregroundColor: Colors.black,
          centerTitle: true,
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
              width: 200,
              height: 50,
              child: ElevatedButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("print pdf"),
                      Icon(Icons.print),
                    ],
                  ),
                  onPressed: () => _createPdf,
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 255, 7, 85),
                      foregroundColor: Colors.black,
                      textStyle: TextStyle(
                        fontSize: 20,
                      ),
                      shape: StadiumBorder())),
            ),
            SizedBox(height: 15,),
            SizedBox(
              width: 200,
              height: 50,
              child: ElevatedButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("print docx"),
                      Icon(Icons.print),
                    ],
                  ),
                  onPressed: () => _createDocx,
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 7, 176, 255),
                      foregroundColor: const Color.fromARGB(255, 0, 0, 0),
                      textStyle: TextStyle(
                        fontSize: 20,
                      ),
                      shape: StadiumBorder())),
            ),
            SizedBox(height: 15,),
            SizedBox(
              width: 200,
              height: 50,
              child: ElevatedButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("print xlsx"),
                      Icon(Icons.print),
                    ],
                  ),
                  onPressed: () => _createXlsx,
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 7, 255, 172),
                      foregroundColor: Colors.black,
                      textStyle: TextStyle(
                        fontSize: 20,
                      ),
                      shape: StadiumBorder())),
            ),



            ]
             
          ),
        ));
  }
}
