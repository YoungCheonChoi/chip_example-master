import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kpostal/kpostal.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.blue),
        home: MainPage(),
      );
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final double spacing = 10;

  List<ChoiceChipData> choiceChips = ChoiceChips.all;

  String postCode = '-';
  String address = '-';

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Choicechip 중복없이'),
        ),
        body: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: choiceChips
                  .map((choiceChip) => ChoiceChip(
                        elevation: 5,
                        label: Text(choiceChip.label),
                        labelStyle: TextStyle(color: Colors.black),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.grey, width: 0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        onSelected: (isSelected) => setState(() {
                          choiceChips = choiceChips.map((otherChip) {
                            final newChip = otherChip.copy(isSelected: false);

                            return choiceChip == newChip
                                ? newChip.copy(isSelected: isSelected)
                                : newChip;
                          }).toList();
                        }),
                        selected: choiceChip.isSelected,
                        selectedColor: Colors.blueAccent,
                        backgroundColor: Colors.white,
                      ))
                  .toList(),
            ),

            SizedBox(height: 20),
            Text("데이터 더미를 리스트 정렬방식, 트레이너 성별, 거리 등등 다 따로만들어야 각자선택가능할듯?"),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: choiceChips
                  .map((choiceChip) => ChoiceChip(
                        elevation: 5,
                        label: Text(choiceChip.label),
                        labelStyle: TextStyle(color: Colors.black),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.grey, width: 0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        onSelected: (isSelected) => setState(() {
                          choiceChips = choiceChips.map((otherChip) {
                            final newChip = otherChip.copy(isSelected: false);

                            return choiceChip == newChip
                                ? newChip.copy(isSelected: isSelected)
                                : newChip;
                          }).toList();
                        }),
                        selected: choiceChip.isSelected,
                        selectedColor: Colors.blueAccent,
                        backgroundColor: Colors.white,
                      ))
                  .toList(),
            ),
            SizedBox(height: 20),

            //주소검색
            Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextButton(
                    onPressed: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => KpostalView(
                            useLocalServer: true,
                            localPort: 1024,
                            callback: (Kpostal result) {
                              setState(() {
                                this.postCode = result.postCode;
                                this.address = result.address;
                              });
                            },
                          ),
                        ),
                      );
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.blue)),
                    child: Text(
                      '주소검색',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(40.0),
                    child: Column(
                      children: [
                        Text('우편 번호',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(this.postCode),
                        Text('주소',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(this.address),
                      ],
                    ),
                  )
                ],
              ),
            ),  //주소검색 끝




          ],
        ),
      );
}

class ChoiceChipData {
  final String label;
  final bool isSelected;
  Color textColor;
  Color selectedColor;

  ChoiceChipData({
    @required this.label,
    @required this.isSelected,
    @required this.textColor,
    @required this.selectedColor,
  });

  ChoiceChipData copy({
    String label,
    bool isSelected,
    Color textColor,
    Color selectedColor,
  }) =>
      ChoiceChipData(
        label: label ?? this.label,
        isSelected: isSelected ?? this.isSelected,
        textColor: textColor ?? this.textColor,
        selectedColor: selectedColor ?? this.selectedColor,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChoiceChipData &&
          runtimeType == other.runtimeType &&
          label == other.label &&
          isSelected == other.isSelected &&
          textColor == other.textColor &&
          selectedColor == other.selectedColor;

  @override
  int get hashCode =>
      label.hashCode ^
      isSelected.hashCode ^
      textColor.hashCode ^
      selectedColor.hashCode;
}

//칩 종류
class ChoiceChips {
  static final all = <ChoiceChipData>[
    ChoiceChipData(
      label: '거리순',
      isSelected: false,
      selectedColor: Colors.blue,
      textColor: Colors.white,
    ),
    ChoiceChipData(
      label: '인기순',
      isSelected: false,
      selectedColor: Colors.blue,
      textColor: Colors.white,
    ),
    ChoiceChipData(
      label: '수강생순',
      isSelected: false,
      selectedColor: Colors.blue,
      textColor: Colors.white,
    ),
    ChoiceChipData(
      label: '가격높은순',
      isSelected: false,
      selectedColor: Colors.blue,
      textColor: Colors.white,
    ),
    ChoiceChipData(
      label: '가격낮은순',
      isSelected: false,
      selectedColor: Colors.blue,
      textColor: Colors.white,
    ),
  ];
}
