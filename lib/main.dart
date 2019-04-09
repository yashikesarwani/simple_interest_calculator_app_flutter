import 'package:flutter/material.dart';

//main function
void main(){
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Simple Interest Calculator App',
      home: SIForm(),
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.indigo,
        accentColor: Colors.indigoAccent
      ),

    )
  );
}

//defining stateful widget class
class SIForm extends StatefulWidget{
  @override

  State<StatefulWidget> createState() {
    return _SIFormState();
  }
}

//create state for stateful widget
class _SIFormState extends State<SIForm>{

  var _formKey = GlobalKey<FormState>();

  var _currencies = ['Rupees', 'Dollars', 'Pounds'];
  var _currentItemSelected = 'Rupees';

  TextEditingController principalController = TextEditingController();
  TextEditingController roiController = TextEditingController();
  TextEditingController termController = TextEditingController();
  var displayResult = '';

  final _minimumPadding = 5.0;  //defining minimum padding.
  @override
  Widget build(BuildContext context){
    TextStyle textStyle = Theme.of(context).textTheme.title;
    return Scaffold(
      //resizeToAvoidBottomPadding: false,
      //Appbar and title
      appBar: AppBar(
        title: Text('Simple Interest Calculator'),
      ),

      //Starting interface
      //create container n replace it by form
      body: Form(
        key: _formKey,
        child: Padding(
        padding: EdgeInsets.all(_minimumPadding * 2),
        //create column n replace it by ListView
        child: ListView(
          children: <Widget>[
            //element-1 of column
            getImageAsset(),

            //element-2 of column
            Padding(
              padding: EdgeInsets.only(top: _minimumPadding, bottom: _minimumPadding),
              child: TextFormField(
              keyboardType: TextInputType.number,
              style: textStyle,
              controller: principalController,
              validator: (String value){
                if (value.isEmpty){
                  return 'Please enter principal amount';
                }
              },
              decoration: InputDecoration(
                labelText: 'Principal',
                hintText: 'Enter principal value e.g. 12000',
                labelStyle: textStyle,
                errorStyle: TextStyle(
                  color: Colors.yellowAccent,
                  fontSize: 15.0
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0)
                )
              ),
            )),

            //element-3 of column
            Padding(
              padding: EdgeInsets.only(top: _minimumPadding, bottom: _minimumPadding),
              child: TextFormField(
              keyboardType: TextInputType.number,
              style: textStyle,
              controller: roiController,
              validator: (String value){
                if (value.isEmpty){
                  return 'Please enter Rate of Interest';
                }
              },
              decoration: InputDecoration(
                  labelText: 'Rate of Interest',
                  hintText: 'In percent',
                  labelStyle: textStyle,
                  errorStyle: TextStyle(
                    color: Colors.yellowAccent,
                    fontSize: 15.0
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0)
                  )
              ),
            )),

            //element-4 of column i.e. a row

            Padding(
              padding: EdgeInsets.only(top: _minimumPadding, bottom: _minimumPadding),
              child: Row(
              children: <Widget>[

                //element-1 of the row
                Expanded(child: TextFormField(
                  keyboardType: TextInputType.number,
                  style: textStyle,
                  controller: termController,
                  validator: (String value){
                    if(value.isEmpty){
                      return 'Please enter time';
                    }
                  },
                  decoration: InputDecoration(
                      labelText: 'Term',
                      hintText: 'Time in years',
                      labelStyle: textStyle,
                      errorStyle: TextStyle(
                        color: Colors.yellowAccent,
                        fontSize: 15.0
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0)
                      )
                  ),
                )),

                Container(width: _minimumPadding * 5 ,),


                //element-2 of the row (Drop down button code)
                Expanded(child: DropdownButton<String>(
                  items: _currencies.map((String dropDownStringItem){

                    return DropdownMenuItem<String>(
                      value: dropDownStringItem,
                      child: Text(dropDownStringItem),
                    );
                  }).toList(),


                  onChanged: (String newValueSelected){
                    //Your code to execute, when a menu item is selected from dropdown.
                    setState((){
                      this._currentItemSelected = newValueSelected;
                    });
                  },

                  value: _currentItemSelected,
                ))

              ],
            )),



          // element-5 of column

           Padding(
             padding: EdgeInsets.only(bottom: _minimumPadding, top: _minimumPadding),
             child: Row(children: <Widget>[
             Expanded(
               child: RaisedButton(
                 color: Theme.of(context).accentColor,
                 textColor: Theme.of(context).primaryColorDark,
                 child: Text('Calculate', textScaleFactor: 1.5,),
                 onPressed: (){
                   setState(() {
                     if (_formKey.currentState.validate()) {
                       this.displayResult = _calculateTotalReturns();
                     }
                   });
                 },
               ),
             ),

             Expanded(
               child: RaisedButton(
                 color: Theme.of(context).primaryColorDark,
                 textColor: Theme.of(context).primaryColorLight,
                 child: Text('Reset', textScaleFactor: 1.5,),
                 onPressed: (){
                   setState(() {
                     _reset();
                   });
                 },
               ),
             ),
           ],)),

           // to do text
           Padding(
             padding: EdgeInsets.all(_minimumPadding * 2),
             child: Text(this.displayResult, style: textStyle,),
           )


          ],
        )),
      ),
    );
  }
  // for getting image on the screen after appbar
  Widget getImageAsset(){
    AssetImage assetImage = AssetImage('images/logo.jpg');
    Image image = Image(image: assetImage, width: 125.0, height: 125.0,);

    return Container(child: image, margin: EdgeInsets.all(_minimumPadding * 10),);

  }


  String _calculateTotalReturns(){
    double principal = double.parse(principalController.text);
    double roi = double.parse(roiController.text);
    double term = double.parse(termController.text);

    double totalAmountPayable = principal + (principal * roi * term)/100;

    String result = 'After $term years, your investment will be worth $totalAmountPayable $_currentItemSelected.';
    return result;
  }

  void _reset() {
    principalController.text = '';
    roiController.text = '';
    termController.text = '';
    _currentItemSelected = _currencies[0];
  }
}



