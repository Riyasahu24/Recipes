import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:recipes/model.dart';

class searchcreen extends StatefulWidget {
  String query;
  searchcreen(this.query);

  @override
  State<searchcreen> createState() => _searchscreenState();
}

class _searchscreenState extends State<searchcreen> {
  TextEditingController searchcontroller = new TextEditingController();
  List<Recipemodel> recipelist = <Recipemodel>[];
  List recipecatlist = [
    {
      "imgurl": "https://images.unsplash.com/photo-1593560704563-f176a2eb61db",
      "heading": "Chilli Food"
    },
    {
      "imgUrl": "https://images.unsplash.com/photo-1593560704563-f176a2eb61db",
      "heading": "Chilli Food"
    },
    {
      "imgUrl": "https://images.unsplash.com/photo-1593560704563-f176a2eb61db",
      "heading": "Chilli Food"
    },
    {
      "imgUrl": "https://images.unsplash.com/photo-1593560704563-f176a2eb61db",
      "heading": "Chilli Food"
    }
  ];

  bool isloading = true;

  getrecipe(String query) async {
    String url =
        "https://api.edamam.com/search?q=$query&app_id=35c73670&app_key=fde00b33e2e8d08bd6fd36c9bc784528";
    var response = await http.get(Uri.parse(url));
    Map data = jsonDecode(response.body);

    setState(() {
      data['hits'].forEach((element) {
        Recipemodel recipemodel = new Recipemodel();
        recipemodel = Recipemodel.fromMap(element['recipe']);
        recipelist.add(recipemodel);
        setState(() {
          isloading = false;
        });
        print(recipelist);
      });
    });
    // recipelist.forEach((Recipe) {
    //   print(Recipe.appcalories);
    // });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getrecipe(widget.query);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0xff213A50), Color(0xff071938)]),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                //Search Bar
                SafeArea(
                  child: Container(
                    //Search Wala Container

                    padding: EdgeInsets.symmetric(horizontal: 8),
                    margin: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24)),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            if ((searchcontroller.text).replaceAll(" ", "") ==
                                "") {
                              print("Blank search");
                            } else {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        searchcreen(searchcontroller.text),
                                  ));
                            }
                          },
                          child: Container(
                            child: Icon(
                              Icons.search,
                              color: Colors.blueAccent,
                            ),
                            margin: EdgeInsets.fromLTRB(3, 0, 7, 0),
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            controller: searchcontroller,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Let's Cook Something!"),
                          ),
                        )
                      ],
                    ),
                  ),
                ),

                Container(
                  child: isloading
                      ? CircularProgressIndicator()
                      : ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: recipelist.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {},
                              child: Card(
                                margin: EdgeInsets.all(15),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                                elevation: 0.0,
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10.0),
                                      child: Image.network(
                                        recipelist[index].appimageurl,
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        height: 220,
                                      ),
                                    ),
                                    Positioned(
                                        left: 0,
                                        right: 0,
                                        bottom: 0,
                                        child: Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 8, horizontal: 10),
                                            decoration: BoxDecoration(
                                              color: Colors.black26,
                                            ),
                                            child: Text(
                                              recipelist[index].applabel,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20),
                                            ))),
                                    Positioned(
                                      right: 0,
                                      width: 80,
                                      height: 40,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(10),
                                              bottomLeft: Radius.circular(10),
                                            )),
                                        child: Center(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.local_fire_department,
                                                size: 18,
                                              ),
                                              Text(recipelist[index]
                                                  .appcalories
                                                  .toString()
                                                  .substring(0, 6)),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
