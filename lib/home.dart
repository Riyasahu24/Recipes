import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:recipes/model.dart';
import 'package:recipes/recipeview.dart';
import 'package:recipes/search.dart';

class homescreen extends StatefulWidget {
  const homescreen({super.key});

  @override
  State<homescreen> createState() => _homescreenState();
}

class _homescreenState extends State<homescreen> {
  TextEditingController searchcontroller = new TextEditingController();
  List<Recipemodel> recipelist = <Recipemodel>[];
  List recipecatlist = [
    {
      "imgurl":
          "https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?auto=format&fit=crop&q=60&w=400&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTB8fGl0YWxpYW4lMjBmb29kfGVufDB8fDB8fHww",
      "heading": "Italian"
    },
    {
      "imgurl":
          "https://images.unsplash.com/photo-1555126634-323283e090fa?auto=format&fit=crop&q=80&w=1064&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      "heading": "Chinese"
    },
    {
      "imgurl":
          "https://plus.unsplash.com/premium_photo-1663127721760-b00877433f09?auto=format&fit=crop&q=80&w=1490&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      "heading": "Spanish"
    },
    {
      "imgurl":
          "https://images.unsplash.com/photo-1608855238293-a8853e7f7c98?auto=format&fit=crop&q=80&w=1470&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      "heading": "French"
    },
    {
      "imgurl":
          "https://images.unsplash.com/photo-1582169296194-e4d644c48063?auto=format&fit=crop&q=80&w=1400&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      "heading": "Mexican"
    }
  ];

  bool isloading = true;

  getrecipe(String query) async {
    String url =
        "https://api.edamam.com/search?q=$query&app_id=35c73670&app_key=fde00b33e2e8d08bd6fd36c9bc784528";
    var response = await http.get(Uri.parse(url));
    Map data = jsonDecode(response.body);

    data['hits'].forEach((element) {
      Recipemodel recipemodel = new Recipemodel();
      recipemodel = Recipemodel.fromMap(element['recipe']);
      recipelist.add(recipemodel);
      setState(() {
        isloading = false;
      });
      print(recipelist);
    });

    recipelist.forEach((Recipe) {
      print(Recipe.appcalories);
      print(Recipe.applabel);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getrecipe("chilli food");
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
                              Navigator.pushReplacement(
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
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "WHAT DO YOU WANT TO COOK TODAY?",
                        style: TextStyle(fontSize: 35, color: Colors.white),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Let's Cook Something New!",
                        style: TextStyle(fontSize: 22, color: Colors.white),
                      )
                    ],
                  ),
                ),

                Container(
                  margin: EdgeInsets.only(top: 15, left: 10),
                  height: 120,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: recipecatlist.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Container(
                        child: InkWell(
                          onTap: () {
                            
                          },
                          child: Card(
                            margin: EdgeInsets.all(12),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18)),
                            elevation: 0.0,
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(18),
                                  child: Image.network(
                                    recipecatlist[index]["imgurl"],
                                    fit: BoxFit.cover,
                                    width: 200,
                                    height: 200,
                                  ),
                                ),
                                Positioned(
                                  left: 0,
                                  right: 0,
                                  top: 0,
                                  bottom: 0,
                                  child: Container(
                                    decoration:
                                        BoxDecoration(color: Colors.black26),
                                    child: Center(
                                        child: Text(
                                      recipecatlist[index]["heading"],
                                      style: TextStyle(
                                          fontSize: 27, color: Colors.white),
                                    )),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
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
                                margin: EdgeInsets.only(
                                    right: 15, left: 15, bottom: 20),
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
