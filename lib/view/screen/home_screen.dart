
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvvm_architecture/model/apis/api_response.dart';
import 'package:flutter_mvvm_architecture/model/media.dart';
import 'package:flutter_mvvm_architecture/view/widget/player_list_widget.dart';
import 'package:flutter_mvvm_architecture/view/widget/player_widget.dart';
import 'package:flutter_mvvm_architecture/viewmodel/media_view_model.dart';



import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _inputController = TextEditingController();
    ApiResponse apiResponse = Provider.of<MediaViewModel>(context,listen: false).response;
    List<Media> mediaList = apiResponse.data as List<Media>;
    return Scaffold(
      appBar: AppBar(
        title: Text('Media Player'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 20.0),
                    decoration: BoxDecoration(
                      color: Theme.of(context).accentColor.withAlpha(50),
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: TextField(
                        style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.grey,
                        ),
                        controller: _inputController,
                        onChanged: (value) {},
                        onSubmitted: (value) {
                          if (value.isNotEmpty) {
                            Provider.of<MediaViewModel>(context,listen: false).setSelectedMedia(null);
                            Provider.of<MediaViewModel>(context, listen: false)
                                .fetchMediaData(value);
                          }
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.grey,
                          ),
                          hintText: 'Enter Artist Name',
                        )),
                  ),
                ),
              ],
            ),
          ),
          mediaList != null && mediaList.length > 0
              ? Expanded(
              child: PlayerListWidget(mediaList, (Media media) {
                Provider.of<MediaViewModel>(context,listen: false).setSelectedMedia(media);
              }))
              : Expanded(
            child: Center(
              child: Text('Search the song by Artist'),
            ),
          ),
          if (Provider.of<MediaViewModel>(context,listen: true).media != null)
            Align(
              alignment: Alignment.bottomCenter,
              child: PlayerWidget(
                function: () {
                  setState(() {});
                },
              ),
            ),
        ],
      ),
    );
  }
}