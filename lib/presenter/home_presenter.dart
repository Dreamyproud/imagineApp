import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:linkedin/models/post_model.dart';
import 'package:linkedin/repository/repository.dart';

class HomePresenter extends StatelessWidget {
  final Repository httpService = Repository();

  @override
  Widget build(BuildContext context) {
    String imgUrl =
        "https://cdn.icon-icons.com/icons2/1154/PNG/512/1486564400-account_81513.png";

    return Scaffold(
      appBar: AppBar(
        title: Text("Posts"),
      ),
      body: FutureBuilder(
        future: httpService.getPosts(),
        builder:
            (BuildContext context, AsyncSnapshot<List<PostModel>> snapshot) {
          if (snapshot.hasData) {
            List<PostModel> posts = snapshot.data;
            return ListView(
              children: posts
                  .map(
                    (PostModel post) => ListTile(
                      title: Text("${post.id}"),
                      subtitle: Text("${post.name}"),
                    ),
                  )
                  .toList(),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget _getText(String name) => Container(
        width: 250,
        child: Text(
          name,
          style: TextStyle(fontSize: 12, color: Colors.black54),
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
        ),
      );

  Widget _returnButtons(IconData icono, String texto) => Column(
        children: [
          Icon(
            icono,
            size: 16,
            color: Colors.grey,
          ),
          SizedBox(height: 4.0),
          Text(texto, style: TextStyle(fontSize: 12, color: Colors.grey)),
          SizedBox(height: 8)
        ],
      );

  Widget _getSizedBox(context) => SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 12,
      child: Container(
        color: Colors.grey[100],
      ));

  Widget _getIconWithOval(IconData icono, Color inkColor, Color iconColor) =>
      ClipOval(
        child: Material(
          color: inkColor, // button color
          child: InkWell(
            splashColor: inkColor, // inkwell color
            child: SizedBox(
              width: 20,
              height: 20,
              child: Icon(
                icono,
                color: iconColor,
                size: 10.0,
              ),
            ),
          ),
        ),
      );
}