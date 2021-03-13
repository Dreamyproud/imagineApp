import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:linkedin/models/post_model.dart';
import 'package:linkedin/presenter/home_presenter.dart';
import 'package:linkedin/repository/repository.dart';

class BodyTemplate extends StatefulWidget {
  @override
  _BodyTemplateState createState() => _BodyTemplateState();
}

class _BodyTemplateState extends State<BodyTemplate> {
  String imgUrl =
      "https://cdn.icon-icons.com/icons2/1154/PNG/512/1486564400-account_81513.png";
  final Repository httpService = Repository();

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Column(
          children: <Widget>[
            //HomePresenter()
            //_stories(),
            //_getSizedBox(context),
            //_posts(context),
          ],
        ),
      );

  Widget _posts(BuildContext context) =>
      Container(width: MediaQuery.of(context).size.width, child: _createPost());

  _createPost() => Container(
        color: Colors.white,
        child: Text("xx")
      );

  List<Widget> listado(List<dynamic> info) {
    List<Widget> lista = [];
    info.forEach((elemento) {
      lista.add(Text(elemento["name"]));
    });
    return lista;
  }

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

  Widget _getText(String name) => Container(
        width: 250,
        child: Text(
          name,
          style: TextStyle(fontSize: 12, color: Colors.black54),
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
        ),
      );

  Widget _getSizedBox(context) => SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 12,
      child: Container(
        color: Colors.grey[100],
      ));
}
