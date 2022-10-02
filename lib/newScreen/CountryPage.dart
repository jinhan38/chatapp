import 'package:app/model/CountryModel.dart';
import 'package:flutter/material.dart';

class CountryPage extends StatefulWidget {
  CountryPage({
    required this.setCountryData,
    Key? key,
  }) : super(key: key);
  final Function setCountryData;

  @override
  State<CountryPage> createState() => _CountryPageState();
}

class _CountryPageState extends State<CountryPage> {
  List<CountryModel> countries = [
    CountryModel(name: "Korea", code: "+90", flag: "Image"),
    CountryModel(name: "Korea2", code: "+90", flag: "Image"),
    CountryModel(name: "Korea3", code: "+90", flag: "Image"),
    CountryModel(name: "Korea4", code: "+90", flag: "Image"),
    CountryModel(name: "Korea5", code: "+90", flag: "Image"),
    CountryModel(name: "Korea6", code: "+90", flag: "Image"),
    CountryModel(name: "Korea7", code: "+90", flag: "Image"),
    CountryModel(name: "Korea8", code: "+90", flag: "Image"),
    CountryModel(name: "Korea9", code: "+90", flag: "Image"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.teal,
            )),
        title: Text("Choose a country",
            style: TextStyle(
                color: Colors.teal,
                fontWeight: FontWeight.w700,
                fontSize: 18,
                wordSpacing: 1)),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.search,
                color: Colors.teal,
              ))
        ],
      ),
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: countries.length,
        itemBuilder: (context, index) {
          return card(countries[index]);
        },
      ),
    );
  }

  Widget card(CountryModel countryModel) {
    return InkWell(
      onTap: () {
        widget.setCountryData(countryModel);
      },
      child: Card(
        margin: EdgeInsets.all(.015),
        child: Container(
          height: 60,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: Row(
            children: [
              Text(countryModel.flag),
              SizedBox(width: 15),
              Text(countryModel.name),
              Expanded(
                child: Container(
                    width: 150,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(countryModel.code),
                      ],
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
