import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:linkedin/helpers/responsive_design/responsive_design.dart';
import 'package:linkedin/models/post_model.dart';
import 'package:linkedin/repository/repository.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class BodyTemplate extends StatefulWidget {
  @override
  _BodyTemplateState createState() => _BodyTemplateState();
}

class _BodyTemplateState extends State<BodyTemplate> {
  String imgUrl =
      "https://cdn.icon-icons.com/icons2/1154/PNG/512/1486564400-account_81513.png";

  final Repository httpService = Repository();
  final RefreshController _refreshController = RefreshController();
  ResponsiveDesign _responsiveDesign;

  @override
  Widget build(BuildContext context) {
    _responsiveDesign = ResponsiveDesign(context);

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[_stories(), _getSizedBox(context), _posts(context)],
      ),
    );
  }

  Widget _posts(BuildContext context) => Container(
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: 1,
            itemBuilder: (context, i) => _createPostNew()),
      );

  Widget _createPostNew() {
    return FutureBuilder(
      future: httpService.getPosts(),
      builder: (BuildContext context, AsyncSnapshot<List<PostModel>> snapshot) {
        if (snapshot.hasData &&
            snapshot.connectionState == ConnectionState.done) {
          List<PostModel> posts = snapshot.data;
          return Column(
              children: posts
                  .map((PostModel post) => Column(
                        children: [
                          Container(
                            color: Colors.white,
                            child: Row(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(
                                      top: 12.0,
                                      left: 18.0,
                                      bottom: 12.0,
                                      right: 12.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(50.0),
                                    child: Image(
                                      image: NetworkImage(imgUrl),
                                      height: 45.0,
                                      width: 45.0,
                                    ),
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${post.name}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.0),
                                      textAlign: TextAlign.start,
                                    ),
                                    _getText('${post.position}'),
                                    _getText('${post.date}'),
                                  ],
                                ),
                                Expanded(child: SizedBox()),
                                IconButton(
                                  icon: Icon(Icons.more_horiz),
                                  iconSize: 30.0,
                                  onPressed: () {
                                    showAlertDialog(context);
                                  },
                                )
                              ],
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              children: [
                                Text(
                                  "${post.summary}",
                                  textAlign: TextAlign.start,
                                ),
                                SizedBox(
                                  height:
                                      _responsiveDesign.heightMultiplier(20),
                                ),
                              ],
                            ),
                          ),
                          FadeInImage(
                            alignment: Alignment.center,
                            width: _responsiveDesign.widthMultiplier(200),
                            image: NetworkImage(imgUrl),
                            placeholder: NetworkImage(
                              'https://www.icegif.com/wp-content/uploads/loading-icegif-1.gif',
                            ),
                          ),
                          Container(
                              color: Colors.white,
                              alignment: Alignment.topLeft,
                              padding: EdgeInsets.only(
                                  top: 5.0, bottom: 5.0, left: 20),
                              child: Row(
                                children: [
                                  _getIconWithOval(
                                      FontAwesomeIcons.solidThumbsUp,
                                      Colors.blue,
                                      Colors.white),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 6),
                                    child: Text("2",
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 12)),
                                  )
                                ],
                              )),
                          Divider(
                            height: 5,
                            color: Colors.grey[350],
                            indent: 2,
                            thickness: 0.0,
                          ),
                          Container(
                              padding:
                                  EdgeInsets.only(top: 5, left: 40, right: 40),
                              color: Colors.white,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  _returnButtons(
                                      FontAwesomeIcons.thumbsUp, 'Like'),
                                  _returnButtons(
                                      FontAwesomeIcons.commentDots, 'Comment'),
                                  _returnButtons(
                                      FontAwesomeIcons.share, 'Share'),
                                  _returnButtons(
                                      FontAwesomeIcons.paperPlane, 'Send'),
                                ],
                              )),
                          _getSizedBox(context),
                        ],
                      ))
                  .toList());
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  showAlertDialog(BuildContext context) {
    Widget cancelButton = FlatButton(
      child: Text("Cancelar"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Continuar"),
      onPressed: () {
        //httpService.deletePost();
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("¿Estás seguro de eliminar esta publicación?"),
      content: Text("Recuerda que no podrás volver a verla."),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
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

  Widget _stories() => Container(
      color: Colors.white,
      width: double.infinity,
      padding: EdgeInsets.only(bottom: 5),
      margin: EdgeInsets.only(top: 6.0, left: 5.0),
      height: 100.0,
      child: _createStories());

  Widget _createStories() => ListView.builder(
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      itemCount: 10,
      itemBuilder: (context, i) => _buttonStories());

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

  Widget _buttonStories() => Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 8.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50.0),
                  border: Border.all(
                    width: 3,
                    color: Colors.blue[400],
                  )),
              child: Container(
                  child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50.0),
                    child: Image(
                      image: NetworkImage(imgUrl),
                      height: 55.0,
                      width: 55.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                      child: Container(
                        child: _getIconWithOval(
                            FontAwesomeIcons.plus, Colors.white, Colors.blue),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50.0),
                            border: Border.all(
                              width: 1,
                              color: Colors.blue[400],
                            )),
                      ),
                      width: 20,
                      height: 20,
                      right: 0,
                      bottom: 0)
                ],
              )),
            ),
          ),
          Text(
            'Your history',
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 13.0),
          )
        ],
      );

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

  Widget _getSizedBox(context) => SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 12,
      child: Container(
        color: Colors.grey[100],
      ));
}
