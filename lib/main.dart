import 'package:flutter/material.dart';

class Link {
  String linkId;
  String name;
  String sequence;
  String url;

  Link({this.name, this.linkId, this.url, this.sequence});
}

class TopTenList extends StatefulWidget {
  @override
  _TopTenListState createState() => _TopTenListState();
}

class _TopTenListState extends State<TopTenList> {
  List<Link> _items = [
    Link(
        linkId: "1", name: "구글", url: "https://www.google.com/", sequence: "1"),
    Link(
        linkId: "2", name: "네이버", url: "https://www.naver.com/", sequence: "2"),
    Link(
        linkId: "3",
        name: "페이스북",
        url: "https://www.facebook.com/",
        sequence: "3"),
    Link(
        linkId: "4", name: "카카오", url: "https://www.kakao.com/", sequence: "4"),
    Link(
        linkId: "5",
        name: "고대디",
        url: "https://kr.godaddy.com/",
        sequence: "5"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hidden Linker"),
      ),
      body: ReorderableListView(
        onReorder: onReorder,
        children: _getListItems(),
      ),
    );
  }

  void onReorder(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }

    setState(() {
      Link link = _items[oldIndex];

      _items.removeAt(oldIndex);
      _items.insert(newIndex, link);
    });
  }

  List<Widget> _getListItems() => _items
      .asMap()
      .map((i, item) => MapEntry(i, _buildTenableListTile(item, i)))
      .values
      .toList();

  Widget _buildTenableListTile(Link item, int index) {
    return Dismissible(
      key: Key(item.linkId),
      dismissThresholds: {
        DismissDirection.endToStart: 0.4,
        DismissDirection.startToEnd: 0.4,
      },
      crossAxisEndOffset: 0.1,
      onDismissed: (direction) {
        setState(() {
          _items.removeAt(index);
        });
      },
      background: Container(color: Colors.red),
      child: ListTile(
        key: ValueKey(item.linkId),
        title: Text(
          'ID: ${item.linkId} / seq: ${item.sequence} / name: ${item.name}',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          'url: ${item.url}',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        onTap: () {},
      ),
    );
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hidden Linker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: TopTenList(),
    );
  }
}
