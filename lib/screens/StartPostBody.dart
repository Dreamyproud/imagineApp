import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:linkedin/repository/repository.dart';

class StartPostBody extends StatefulWidget {
  @override
  _StartPostBodyState createState() => _StartPostBodyState();
}

class _StartPostBodyState extends State<StartPostBody> {
  final _post = Repository.postList;
  String imgUrl =
      "https://media-exp1.licdn.com/dms/image/C4D35AQFGSNotlnM8mA/profile-framedphoto-shrink_200_200/0/1614185454794?e=1615525200&v=beta&t=sn7BZsg5KrYg3hvIoTLPOmRYxWHZZ10a5zK-3E2JLsA";

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          _headerStartPost(),
          _startPost(context),
        ],
      ),
    );
  }

  Widget _startPost(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: _createStartPost(context)
    );
  }

  _createStartPost(context) {
    return Column(
      children: <Widget>[
        Container(
            color: Colors.white,
            child:TextFormField(
              autofocus: false,
              decoration: InputDecoration(
                hintText: 'What do you want to talk about',
                alignLabelWithHint: true,
                contentPadding: new EdgeInsets.symmetric(vertical: 100.0, horizontal: 10.0),
              ),
              validator: (val) {
                if(val.length==0) {
                  return "Email cannot be empty";
                }else{
                  return null;
                }
              },
              keyboardType: TextInputType.emailAddress,
              style: new TextStyle(
                fontFamily: "Poppins",
              ),
            ),),
        _getSizedBox(context),
      ],
    );
  }

  Widget _getText(String name) {
    return Container(
      width: 250,
      child: Text(
        name,
        style: TextStyle(fontSize: 12, color: Colors.black54),
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
      ),
    );
  }

  Widget _headerStartPost() {
    return Container(
        color: Colors.white,
        width: double.infinity,
        padding: EdgeInsets.only(bottom: 5),
        margin: EdgeInsets.only(top: 6.0, left: 5.0),
        height: 60.0,
        child: _createHeader());
  }

  Widget _createHeader() {
    return Row(
      children: [
        Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 8.0),
              child: Container(
                  alignment: Alignment.topLeft,
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
                    ],
                  )),
            ),
          ],
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Row(
            children: [
              OutlineButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(FontAwesomeIcons.solidUser, color: Colors.grey, size: 15),
                      Text("Nicolas Rojas Nino"),
                    ],
                  ),
                  onPressed: null,
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0))),
              SizedBox(width: 10,),
              OutlineButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(FontAwesomeIcons.globeAmericas, color: Colors.grey, size: 15),
                      Text("Anyone"),
                      Icon(FontAwesomeIcons.sortDown, color: Colors.grey, size: 15),

                    ],
                  ),
                  onPressed: null,
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0)))
            ],
          )
        )
      ],
    );
  }
  _getSizedBox(context) => SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 12,
      child: Container(
        color: Colors.grey[100],
      ));
}
