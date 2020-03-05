import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:alisverislistemflutter/models/shop.dart';
import 'package:alisverislistemflutter/ui/styles/text_style.dart';
import 'package:alisverislistemflutter/ui/widgets/custom_icon_button.dart';

void main() => runApp(MyApp());
const kBtnColor = Color(0xFFF29BBB);

var formKey = GlobalKey<FormState>();

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Alışveriş Listem',
      theme: ThemeData(
        primaryColor: kThemePrimary,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Alışveriş Listem'),
        ),
        body: InputPage(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (formKey.currentState.validate()) {
              formKey.currentState.save();
            }
          },
          child: Icon(
            Icons.add,
          ),
          backgroundColor: Color(0xFFF21D81),
        ),
      ),
    );
  }
}

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  String urunAdi;
  int urunMiktar = 0;
  String urunCins;
  double urunFiyat;
  List<Shop> tumAlisveris;
  int sayac = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tumAlisveris = [];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kBgColor,
      child: Form(
        key: formKey,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 16.0, left: 8.0, right: 8.0),
              child: TextFormField(
                style: kItemFormStyle,
                validator: (enteredItemName) {
                  if (enteredItemName.length > 0) {
                    return null;
                  } else {
                    return 'Ürün adını doldurunuz';
                  }
                },
                decoration: InputDecoration(
                  labelText: 'Ürün',
                  labelStyle: kLabelStyle,
                  hintText: 'Ürün adı giriniz',
                  hintStyle: kHintStyle,
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color(0xFFF29BBB), width: 2.0),
                  ),
                ),
                onSaved: (value) {
                  urunAdi = value;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: EdgeInsets.all(16),
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text(
                      'Miktar :',
                      style: kItemStyle,
                    ),
                    CustomIconButton(kBtnColor, Icons.remove, () {
                      setState(() {
                        if (urunMiktar > 0) {
                          return urunMiktar--;
                        } else {
                          return 'Miktar eksi olamaz';
                        }
                      });
                    }),
                    Text(
                      urunMiktar.toString(),
                      style: kItemQtTextStyle,
                    ),
                    CustomIconButton(kBtnColor, Icons.add, () {
                      setState(() {
                        if (urunMiktar >= 0) {
                          return urunMiktar++;
                        } else {
                          return 'Miktar eksi olamaz';
                        }
                      });
                    }),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Birim :',
                        style: kItemStyle,
                      ),
                    ),
                    DropdownButton<String>(
                        items: addUnitItems(),
                        value: urunCins,
                        onChanged: (selectedUnit) {
                          setState(() {
                            urunCins = selectedUnit;
                          });
                        })
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                style: kItemFormStyle,
                validator: (enteredPrice) {
                  if (enteredPrice.length > 0) {
                    return null;
                  } else {
                    return 'Ürün fiyatını girin';
                  }
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color(0xFFF29BBB), width: 2.0),
                  ),
                  labelText: 'Fiyat',
                  labelStyle: kLabelStyle,
                  hintText: 'Fiyat Girin',
                  hintStyle: kHintStyle,
                ),
                onSaved: (value) {
                  urunFiyat = double.tryParse(value);
                  setState(() {
                    urunFiyat = urunFiyat * urunMiktar;
                    tumAlisveris
                        .add(Shop(urunAdi, urunMiktar, urunCins, urunFiyat));
                  });
                },
                keyboardType: TextInputType.number,
              ),
            ),
            Expanded(
              child: Container(
                child: ListView.builder(
                    itemBuilder: createShoppingList,
                    itemCount: tumAlisveris.length),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<DropdownMenuItem<String>> addUnitItems() {
    List<DropdownMenuItem<String>> units = [];
    units.add(DropdownMenuItem(
      child: Text(
        'Kg',
        style: kDropBtnStyle,
      ),
      value: 'Kg',
    ));
    units.add(DropdownMenuItem(
      child: Text('Adet', style: kDropBtnStyle),
      value: 'Adet',
    ));
    units.add(DropdownMenuItem(
      child: Text('L', style: kDropBtnStyle),
      value: 'L',
    ));
    units.add(
      DropdownMenuItem(
        child: Text('ML', style: kDropBtnStyle),
        value: 'ML',
      ),
    );
    return units;
  }

  Widget createShoppingList(BuildContext context, int index) {
    sayac++;
    return Dismissible(
      key: Key(sayac.toString()),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) {
        setState(() {
          tumAlisveris.removeAt(index);
        });
      },
      child: Container(
        child: Card(
          color: Color(0xFFF2CED8),
          shape: RoundedRectangleBorder(
              side: BorderSide(color: kThemePrimary, width: 2),
              borderRadius: BorderRadius.circular(8)),
          elevation: 8,
          child: ListTile(
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                tumAlisveris[index].itemName,
                style: kTitleStyle,
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                tumAlisveris[index].itemQuantity.toString() +
                    ' ' +
                    tumAlisveris[index].itemType +
                    ' ' +
                    tumAlisveris[index].itemPrice.toString() +
                    ' ' +
                    '₺',
                style: kSubtitleStyle,
              ),
            ),
            leading: Icon(
              Icons.star,
              size: 32,
              color: kThemePrimary,
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 32,
              color: kThemePrimary,
            ),
          ),
        ),
      ),
    );
  }
}
