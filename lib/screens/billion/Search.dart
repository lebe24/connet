import 'package:app/constants/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class SearchBox extends StatelessWidget {

  final ValueChanged onChanged;

  const SearchBox({Key key, this.onChanged}) :super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top:70, right: kDefaultPadding ,left: kDefaultPadding),
      padding: EdgeInsets.symmetric(
        horizontal: kDefaultPadding,
        vertical: kDefaultPadding/4
      ),
      decoration: BoxDecoration(
        color: kblack.withOpacity(0.6),
        borderRadius:BorderRadius.circular(10)
      ),
      child: TextField(
      
        onChanged : onChanged,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: kgold),
        decoration: InputDecoration(
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          icon: SvgPicture.asset("assets/icons/search.svg"),
          hintText: 'Search',
          hintStyle: TextStyle(color: Colors.white),
        ),
      )
    );
  }
}