 import 'package:flutter/material.dart';
 import 'package:flutter/foundation.dart';
 import 'package:clipboard/clipboard.dart';
 import 'package:intl/intl.dart';
 import 'package:metadata_fetch/metadata_fetch.dart';
 import 'dart:convert';
 import 'package:url_launcher/url_launcher.dart';
 import 'package:shared_preferences/shared_preferences.dart';
 import 'package:flutter_slidable/flutter_slidable.dart';
 import 'package:share/share.dart';
 import 'package:hidden_linker_flutter/screens/edit_link_page.dart';
 import 'dart:developer' as developer;

 class Link {
  String id;
  String url;
  String title;
  String description;
  String createdAt;
  bool checked;

  Link({this.id, this.url, this.title, this.description, this.createdAt, this.checked});

  Link.fromJson(Map<String, String> json)
      : id = json['id'],
        url = json['url'],
        title = json['title'],
        description = json['description'],
        createdAt = json['createdAt'],
        checked = json['checked'].toLowerCase() == 'true';

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'url': url,
      'title': title,
      'description': description,
      'createdAt': createdAt,
      'checked' : checked,
    };
  }
}

class ScreenArguments {
  final dynamic title;
  final dynamic description;
  final dynamic url;

  ScreenArguments(this.title, this.description, this.url);
}
    
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Link> _items = [];

  final myController = TextEditingController();
  initState() {
    super.initState();
    _init();
    _setClipboard();
  }

  void _init () async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var list = prefs.getString('linkList');

    setState(() {
      var linkList = jsonDecode(list).map<Link>((item) {
        return new Link(
          id: item['id'],
          url: item['url'],
          title: item['title'],
          description: item['description'],
          createdAt: item['createdAt'],
          checked: item['checked'],
        );
      }).toList();
      _items = linkList;
    });
  }

  void _setClipboard() async {
    FlutterClipboard.paste().then((value) {
      myController.text = value;
    });
  }

  getUrlData(final url) async {
    var data = await MetadataFetch.extract(url);

    return data;
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
    setListAtLocal();
  }

  void addList () async {
    String url = myController.text;
    String id = DateFormat('yyyyMMddkkmmsss').format(DateTime.now());
    String createdAt = DateFormat('yyyy-MM-dd').format(DateTime.now());
    dynamic urlData = await getUrlData(url);
    
    var result = Link(
      id: id,
      url: myController.text,
      title: urlData.title != null ? urlData.title : '',
      description: urlData.description != null ? urlData.description : '',
      createdAt: createdAt,
      checked: false,
    );

    setState(() {
      _items.add(result);
    });

    myController.text = '';
    setListAtLocal();
  }

  void setListAtLocal () async {
    var list = jsonEncode(_items);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('linkList', list);
  }

  _moveEditPageAndEdit(BuildContext context, Link link) async {
    final result = await Navigator.pushNamed(
      context,
      EditLinkPage.routeName,
      arguments: {
        "title": link.title,
        "url": link.url,
        "description": link.description,
        "linkId": link.id,
      }
    );

    if (result != null) {
      Map<String, dynamic> editResult = result;
      Link editItem = _items.firstWhere((item) => item.id == editResult["linkId"]);
      editItem.title = editResult["title"];
      editItem.url = editResult["url"];
      editItem.description = editResult["description"];

      setState(() { _items = _items; });
      setListAtLocal();
    }
  }

  List<Widget> _getListItems() => _items
      .asMap()
      .map((i, item) => MapEntry(i, _buildTenableListTile(item, i)))
      .values
      .toList();

  Widget _buildTenableListTile(Link item, int index) {
    return Slidable(
      key: Key(item.id),
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: Row(
        children: <Widget>[
          Expanded(
            child:  Container(
              child: Checkbox(
                value: item.checked,
                onChanged: (bool value) {
                  item.checked = value;
                  setState(() {
                    _items = _items;
                  });
                  setListAtLocal();
                }
              ),
            ),
          ),
          Expanded(
            flex: 9,
            child: ListTile(
              contentPadding: EdgeInsets.only(left: 0.0, right: 0.0),
              title: Row(
                children: <Widget>[
                  Expanded(
                    // flex: 2,
                    flex: 7,
                    child: Text(
                      "${item.title}",
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                    margin: const EdgeInsets.only(left: 10.0),
                      child : Text("${item.createdAt}")
                    ),
                  ),
                ],
              ),
              subtitle: Text(
                '${item.url}',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              onTap: () async => await launch('${item.url}'),
            )
          ),
        ]
      ),
      
      actions: <Widget>[
        IconSlideAction(
          caption: 'Share',
          color: Colors.indigo,
          icon: Icons.share,
          onTap: () => Share.share(item.url),
        ),
      ],
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'Edit',
          color: Colors.blue,
          icon: Icons.edit,
          onTap: () {
            // Navigator.pushNamed(
            //   context,
            //   EditLinkPage.routeName,
            //   arguments: {
            //     "title": item.title,
            //     "url": item.url,
            //     "description": item.description,
            //   }
            // );
            _moveEditPageAndEdit(context, item);
          },
        ),
        IconSlideAction(
          caption: 'Delete',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () {
            setState(() {
              _items.removeAt(index);
            });
            setListAtLocal();
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ReorderableListView(
        onReorder: onReorder,
        children: _getListItems(),
      ),
      bottomSheet: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Expanded(
              child: TextField(
                controller: myController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'url',
                )
              ),
            ),
            Container(
              width: 80.0,
              height: 60.0,
              margin: const EdgeInsets.only(left: 10.0),
              child : ElevatedButton(
                onPressed: addList,
                child: Text(
                  'add',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ],
        )
      )
    );
  }
}
