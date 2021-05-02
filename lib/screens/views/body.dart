import 'package:app/screens/billion/DetailBody.dart';
import 'package:app/screens/billion/Search.dart';
import 'package:app/model/bilionaire_model.dart';
import 'package:app/screens/billion/real_time.dart';
import 'package:app/network/tempApi.dart';
import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  

  List<Data> _notes = List<Data>();
  List<Data> _notesForDisplay = List<Data>();

  @override
  void initState() {
    fetchNotes().then((value) {
      setState(() {
        _notes.addAll(value);
        _notesForDisplay = _notes;
      });
    });
    super.initState();
  }

  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Column(
        children:[
          SearchBox(onChanged:(value){
            value = value.toLowerCase();
            setState(() {
              _notesForDisplay = _notes.where((note){
                var noteTitle = note.personName.toLowerCase();
                return noteTitle.contains(value);
              }).toList();
            });
            
          }),
          SizedBox(height:10),
          Expanded(
            child:_notesForDisplay.length == 0 ? Center(child: CircularProgressIndicator()) : Container(
              child: Container(
                
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: _notesForDisplay.length,
                  itemBuilder: (context,index)=> RealTime(
                    item: index ,
                    data: _notesForDisplay[index],
                    press:(){
                      Navigator.push(context, 
                      MaterialPageRoute(
                        builder:(context) => DetailBody(
                          data: _notesForDisplay[index],
                        ))
                      );
                    }
                  )
                ),
              ),
            ),
          ),
        ]
      ),
    );
  }
}