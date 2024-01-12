// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:foodshare/data/local_database.dart';
import 'package:foodshare/pages/results_page.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SearchPage extends StatefulWidget {
  SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  // Init action
  @override
  void initState(){
    if(_myBox.get("history_items") == null){
      db.createInitialData();
    } else{
      db.loadData();
    }

    super.initState();
  }

  // Variables
  TextEditingController _searchKeywordController = TextEditingController();
  String searchKeyword = "";
  int historyItemCount = 0; 
  final _myBox = Hive.box("myBox");
  LocalDatabase db = LocalDatabase();
  
  // actions
  String toTitleCase(String text) {
    List words = text.split(' ');
    List titleCaseWords = words.map((word) {
      if (word.isEmpty) {
        return '';
      }
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    }).toList();
    return titleCaseWords.join(' ');
  }
  void add_history(String item){
    setState(() {
      if(db.historyItems.length == 10){
        db.historyItems.removeLast();
      }
      if(!db.historyItems.contains(item)){
        db.historyItems.insert(0, item);
      }
    });
    db.updateDatabase();
  }

  void search_action(){
    if(_searchKeywordController.text != ""){
        setState(() {
        searchKeyword = _searchKeywordController.text;
        add_history(toTitleCase(searchKeyword));
        Navigator.pushNamed(context, '/resultspage', arguments: searchKeyword);
    });
    }
  }

  // Widgets
  Widget history_item(String item){
    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, '/resultspage', arguments: item);
      },
      child: Container(
        margin: EdgeInsets.only(right: 12, top: 14),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(
          color: Color.fromRGBO(239, 239, 239, 1),
          borderRadius: BorderRadius.circular(100)
        ),
        child: Text(
          item,
          style: TextStyle(
            fontFamily: "Urbanist",
            fontSize: 15
          ),
        ),
      ),
    );
  }

  // Widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Colors.transparent,
        toolbarHeight: 100,
        title: Padding(
          padding: EdgeInsets.only(right: 15),
          child: Container(
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Color.fromRGBO(239, 239, 239, 1)
            ),
            child: Row(
              children: [
                SizedBox(width: 20,),
                GestureDetector(
                  onTap: search_action,
                  child: Icon(
                    Icons.search,
                    color: Color.fromRGBO(0, 0, 0, 1),
                    size: 25,
                  ),
                ),
                Expanded(
                  child: TextField(
                   controller: _searchKeywordController,
                   onSubmitted: (context) => search_action(),
                    style: TextStyle(
                      fontFamily: 'Urbanist',
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(top: 10, bottom: 10, right: 20, left: 10),
                      hintText: "What food is on your mind?",
                      hintStyle: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 0.5)
                      )
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        leadingWidth: 42,
        leading: GestureDetector(
          onTap: (){},
          child: Padding(
            padding: EdgeInsets.only(left: 20),
            child: Icon(
              Icons.arrow_back_ios,
              color: Color.fromRGBO(43, 192, 159, 1),
              size: 35,
            ),
          ),
        ),
      ),
      backgroundColor: Color.fromRGBO(248, 248, 248, 1),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 0),
        child: ListView(
          children: [
            Text(
              "History",
              style: TextStyle(
                fontFamily: "Urbanist",
                fontWeight: FontWeight.w700,
                fontSize: 20
              ),
            ),
            Wrap(
              children: db.historyItems.asMap().entries.map((entry){
                return history_item(entry.value);
              }).toList(),
            )
          ],
        ),
      ),
    );
  }
}