import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  Widget _getTitleSection() {
    return Container(
      padding: const EdgeInsets.all(32),
      child: Row(
        children: [
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: const Text(
                    'Oeschinen Lake Campground',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  )),
              Text(
                'Kandersteg, Switzerland',
                style: TextStyle(color: Colors.grey[500]),
              )
            ],
          )),
          const FavoriteWidget()
        ],
      ),
    );
  }

  Widget _getButtonColumn(
    Color color,
    IconData icon,
    String label,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: color,
        ),
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: Text(
            label,
            style: TextStyle(
                fontSize: 12, fontWeight: FontWeight.w400, color: color),
          ),
        ),
      ],
    );
  }

  Widget _getButtonSection(Color color) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        _getButtonColumn(color, Icons.call, 'CALL'),
        _getButtonColumn(color, Icons.near_me, 'ROUTE'),
        _getButtonColumn(color, Icons.share, 'SHARE'),
      ]),
    );
  }

  Widget _getTextSection() {
    return const Padding(
      padding: EdgeInsets.all(32),
      child: Text(
        'Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese '
        'Alps. Situated 1,578 meters above sea level, it is one of the '
        'larger Alpine Lakes. A gondola ride from Kandersteg, followed by a '
        'half-hour walk through pastures and pine forest, leads you to the '
        'lake, which warms to 20 degrees Celsius in the summer. Activities '
        'enjoyed here include rowing, and riding the summer toboggan run.',
        softWrap: true,
      ),
    );
  }

  Widget _getImageSection() {
    return Container(
      padding: const EdgeInsets.only(bottom: 8),
      child: Image.asset(
        'assets/images/lake.jpg',
        width: 600,
        height: 240,
        fit: BoxFit.cover,
      ),
    );
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Layout Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
            appBar: AppBar(
              title: const Text("Flutter Layout Demo"),
            ),
            body: ListView(children: [
              _getImageSection(),
              _getTitleSection(),
              _getButtonSection(Theme.of(context).primaryColor),
              _getTextSection()
            ])));
  }
}

class FavoriteWidget extends StatefulWidget {
  const FavoriteWidget({Key? key}) : super(key: key);

  @override
  _FavoriteWidgetState createState() => _FavoriteWidgetState();
}

class _FavoriteWidgetState extends State<FavoriteWidget> {
  bool _isFavorited = true;
  int _favoriteCount = 41;

  void _toggleFavorite() {
    setState(() {
      if (_isFavorited) {
        _isFavorited = false;
        _favoriteCount--;
      } else {
        _isFavorited = true;
        _favoriteCount++;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    const color = Colors.red;
    return Row(mainAxisSize: MainAxisSize.min, children: [
      Container(
        padding: const EdgeInsets.all(0),
        child: IconButton(
            onPressed: _toggleFavorite,
            icon: (_isFavorited
                ? const Icon(
                    Icons.star,
                    color: color,
                  )
                : const Icon(
                    Icons.star_border,
                    color: color,
                  ))),
      ),
      SizedBox(
        width: 18,
        child: SizedBox(
          child: Text('$_favoriteCount'),
        ),
      )
    ]);
  }
}
