import 'dart:convert';
import 'dart:async' show Future;
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_sound/flutter_sound.dart';
import 'package:kidstarter/constant.dart';
import 'package:kidstarter/entities/color.dart';
import 'package:kidstarter/widgets/page_header.dart';
import 'package:kidstarter/widgets/tile_card.dart';

Future<List<ColorEntity>> _fetchColors() async {
  String jsonString = await rootBundle.loadString('assets/data/colors.json');
  final jsonParsed = json.decode(jsonString);

  return jsonParsed
      .map<ColorEntity>((json) => ColorEntity.fromJson(json))
      .toList();
}

class ColorsScreen extends StatefulWidget {
  final String title;
  final Color primaryColor;
  final Color secondaryColor;

  ColorsScreen({
    required this.title,
    required this.primaryColor,
    required this.secondaryColor,
  });

  @override
  _ColorsScreenState createState() => _ColorsScreenState();
}

class _ColorsScreenState extends State<ColorsScreen> {
  late Future<List<ColorEntity>> _colorsFuture;
  FlutterSoundPlayer? _soundPlayer;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();

    _colorsFuture = _fetchColors();
    _soundPlayer = FlutterSoundPlayer();
    _soundPlayer!.openPlayer();
  }

  void _playAudio(String audioPath) async {
    // Load a local audio file and get it as a buffer
    Uint8List buffer = (await rootBundle.load(audioPath)).buffer.asUint8List();
    await _soundPlayer!.startPlayer(fromDataBuffer: buffer);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          PageHeader(
            title: widget.title,
            primaryColor: widget.primaryColor,
            secondaryColor: widget.secondaryColor,
          ),
          Expanded(
            child: FutureBuilder(
              future: _colorsFuture,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 20.0,
                      ),
                      itemCount: (snapshot.data as List<ColorEntity>).length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: index % 2 == 0
                              ? const EdgeInsets.only(bottom: 20, left: 20)
                              : const EdgeInsets.only(bottom: 20, right: 20),
                          child: TileCard(
                            isActive: _selectedIndex == index,
                            title: (snapshot.data as List<ColorEntity>)[index].name,
                            textColor: (snapshot.data as List<ColorEntity>)[index].name == 'White'
                                ? kTitleTextColor
                                : Colors.white,
                            backgroundColor:
                                Color(int.parse((snapshot.data as List<ColorEntity>)[index].code)),
                            fontSizeBase: 30,
                            fontSizeActive: 40,
                            onTap: () {
                              setState(() {
                                _selectedIndex = index;
                              });

                              _playAudio((snapshot.data as List<ColorEntity>)[index].audio);
                            },
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  return Center(
                    child: Text('Loading...'),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _soundPlayer?.closePlayer();
    super.dispose();
  }
}
