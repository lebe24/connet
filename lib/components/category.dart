import 'package:app/constants/constant.dart';
import 'package:flutter/material.dart';

class CategoryList extends StatefulWidget {
  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {

  int selectedIndex = 0;



   List categories = [Youngest,Industries];
          @override
          Widget build(BuildContext context) {
            return Container(
              margin: EdgeInsets.symmetric(vertical :kDefaultPadding/2),
              height: 30,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (context ,index) => GestureDetector(
                  onTap:(){
                    setState((){
                      selectedIndex = index;
                    });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(left : kDefaultPadding ,right: index == categories.length - 1 ? kDefaultPadding : 0),
                    padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                    decoration: BoxDecoration(
                      color: index == selectedIndex
                          ? Colors.white
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: categories[index]
                  ),
                )
              )
            );
          }
        }
  
  class Youngest extends StatefulWidget{

  Youngest({Key key}) : super(key: key);

   @override
  _YoungestState createState() => _YoungestState();
}
class _YoungestState extends State<Youngest> {

  String dpValue = 'one';

   @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      elevation: 18,
      value: dpValue,
      style: TextStyle(

        fontWeight: FontWeight.bold,
        color: Colors.yellow,),
      underline: null,
      onChanged: (String newValue){
        setState(() {
          dpValue = newValue;
        });
      },
      items: <String>[
        'one','two' ,'Three'
      ].map<DropdownMenuItem<String>>((String value){
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

}
  
  class All {
}
  
  class Country {
}
  
  class Industries {
}