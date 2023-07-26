import 'dart:async';

import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:url_launcher/url_launcher.dart';

import 'iterable_structure_maker.dart';
import 'hardcoding_stamp_maker.dart';
import 'super_helper.dart';

class BizmekaWorkStratTimeRecordHelper extends StatefulWidget {
  String text;
  final Color color;
  final FontWeight fontWeight;
  final double fontSize;
  final Color backgroundColor;
  final double paddingVertical;
  final double paddingHorizontal;
  final BorderRadius borderRadius;

  BizmekaWorkStratTimeRecordHelper({
    Key? key,
    required this.text,
    required this.backgroundColor,
    required this.color,
    required this.fontSize,
    required this.fontWeight,
    required this.paddingVertical,
    required this.paddingHorizontal,
    required this.borderRadius,
  }) : super(key: key);

  @override
  State<BizmekaWorkStratTimeRecordHelper> createState() => _BizmekaWorkStratTimeRecordHelperState();
}

class _BizmekaWorkStratTimeRecordHelperState extends State<BizmekaWorkStratTimeRecordHelper> {
  String itemsToCopy = '-';
  late Map<String, dynamic> stamps;
  var helper = MySuperHelpers();
  int clickCounter = 0;
  late List<String> items;


  late IterableStringListMaker itemsIterable;
  late List<dynamic> itemsSnapshotAtStart;

  late String buttonTitle;
  
  final LocalStorage storage = LocalStorage('foo.foo');

  
  late bool isChecked;

  late int itemsLength;

  @override
  void initState() {
    super.initState();
    buttonTitle = widget.text;
    initStatesOfThisButton();
    
    initIsChecked();
    //currentWindow  vs   newTab  vs  newWindow

    //currentWindow  vs   newTab
    //way1
    // String option_blank_or_self = '_blank'; // _self
    // js.context.callMethod('open', [url.toString(), option_blank_or_self]);
    //way2
    // html.window.open(url.toString(), 'new tab');
    //way2-1
    // html.window.location.href = url.toString();
    //way3
    // launch(url.toString(), isNewTab: true);

    //newTab
    // runUrl(url:URL); //이것도 안되네...기존 login 정보 접근 불가.

    //newWindow

    // html.window.onKeyPress.listen((html.KeyboardEvent e) {
    //   print(e.charCode.toString() + " " + new String.fromCharCode(e.charCode));
    // });

    // ServicesBinding.instance.keyboard.addHandler(_onKey);

    // naturalNumbers = NaturalNumbers(EndLimit: 100);

    // print(itemsIterable.All().toString());
    // itemsIterable.next();
    // itemsIterable.next();
    // itemsIterable.next();
    // print(itemsIterable.first_at_born().toString());
    // print(itemsIterable.first_at_born());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: widget.borderRadius,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: widget.paddingHorizontal,
        vertical: widget.paddingVertical,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
              child: Text(
                widget.text.length <= 60 ? '${widget.text} $clickCounter/$itemsLength' : '${widget.text.substring(0, 60)} $clickCounter/$itemsLength',
                style: TextStyle(
                  color: widget.color,
                  fontSize: widget.fontSize,
                  fontWeight: widget.fontWeight,
                ),
              ),
              onPressed: () {
                processBySpecialOrderedByMe();
              }),
          SizedBox(
            width: 40,
            child: IconButton(
              icon: const Icon(
                Icons.animation,
              ),
              color: Colors.lightBlueAccent, //상큼
              onPressed: () {
                showDialog<void>(
                  context: context,
                  barrierDismissible: false, // user must tap button!
                  builder: (BuildContext context) {
                    return AlertDialog(
                      backgroundColor: Colors.black,
                      title: Text(
                        buttonTitle,
                        style: const TextStyle(color: Colors.blueAccent),
                      ),
                      content: SingleChildScrollView(
                        child: ListBody(
                          children: <Widget>[
                            for (var item in itemsSnapshotAtStart) hardCodingStampMaker(txt: item, backgroundColor: MyColors.blackUndefined, color: MyColors.whiteClear, fontSize: 10, fontWeight: FontWeight.w200, paddingVertical: 5, paddingHorizontal: 4, borderRadius: BorderRadius.circular(5)),
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: const Text(
                            '닫기',
                            style: TextStyle(color: Colors.lightBlueAccent),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
                // if (_formKey.currentState.validate()) {
                //   _formKey.currentState.save();
                // }
              },
            ),
          ),
          IconButton(
            onPressed:  onToogleIsChecked,
            icon: isChecked == true
                ? const Icon(
                    // Icons.check,
                    Icons.check_box_outlined,
                    color: Colors.lightBlueAccent, //상큼
                  )
                : const Icon(
                    Icons.check_box_outline_blank,
                    color: Colors.lightBlueAccent, //상큼
                  ),
            //check_box_outline_blank
            //         Icon(
            //           Icons.check_box_outline_blank,
            //           color: Colors.lightBlueAccent, //상큼
            //         ),
          ),
        ],
      ),
    );
  }

  void processBySpecialOrderedByMe({
    String? hostOperatingEnvironment, //아무래도 언젠가 이게 꼭 필요하지않을까 생각된다
  }) {
    setState(() {
      // print("itemsIterable.length:"+itemsIterable.length_at_born.toString());//DEVELOPMENT
      int i = -1;
      while (true) {
        if (clickCounter == i) {
          printWithoutError("ClickCounter:$clickCounter"); //DEVELOPMENT
          printWithoutError('copied : $itemsToCopy'); //DEVELOPMENT
          FlutterClipboard.copy(itemsToCopy).then((value) {});
          try {
            itemsToCopy = itemsIterable.next();
          } catch (e) {
            // print(e);//DEVELOPMENT
            initStatesOfThisButton();
            itemsToCopy = itemsIterable.next();
          }
          widget.text = itemsToCopy;
        }
        i++;
        if (i == itemsIterable.itemLengthSnapshotAtBorn + 1) {
          break;
        }
      }
      clickCounter = clickCounter + 1;
    });
  }

  Future<void> runUrl({
    required String url,
    String? mode,
  }) async {
    if (!await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  // bool _onKey(KeyEvent event, [bool isCtrlPressed = false, bool isVPressed = false, bool isCtrlVPressed = false]) {
  //   //keyboard infinite loop  입니다.  ctrl v 를 눌러야만 나갈 수 있습니다.
  //   var key = event.logicalKey.keyLabel;
  //   if (event is KeyDownEvent) {
  //     // print("Key down: $key");
  //   } else if (event is KeyUpEvent) {
  //     // print("Key up: $key");
  //   } else if (event is KeyRepeatEvent) {
  //     // print("Key repeat: $key");
  //   }
  //   printWithoutErrorOrPrintWithError(event.logicalKey.keyLabel);
  //   if (event.logicalKey.keyLabel.contains('Control Left')) {
  //     isCtrlPressed = true;
  //   }
  //   printWithoutErrorOrPrintWithError(event.logicalKey.keyLabel);
  //   if (event.logicalKey.keyLabel.contains('V')) {
  //     isVPressed = true;
  //   }
  //   printWithoutErrorOrPrintWithError(event.logicalKey.keyLabel);
  //   if (isCtrlPressed == true && isVPressed == true) {
  //     isCtrlVPressed = true;
  //   } else {
  //     // isCtrlVPressed = false;
  //     // isCtrlPressed = false;
  //     // isVPressed = false;
  //   }
  //   // print(isCtrlVPressed);
  //
  //   if (isCtrlVPressed == true) {
  //     printWithoutErrorOrPrintWithError('조합키로서 ctrl V 눌렸습니다.');
  //   }
  //
  //   return false;
  // }

  void initStatesOfThisButton() {
    reloadItems();
    clickCounter = 0;
  }

  void reloadItems() {
    // Stamps = COMMON_TEXT_DATA().STAMPS;
    items = [
      // buttonTitle+'[시작]', //DEVELOPMENT
      'https://ezgroupware.bizmeka.com/groupware/todo/listMenuStoredTaskView.do?folderId=1263453&folderName=&#37;EC&#37;9D&#37;BC&#37;EC&#37;9D&#37;BC&#37;EC&#37;97&#37;85&#37;EB&#37;AC&#37;B4&#37;EB&#37;B3&#37;B4&#37;EA&#37;B3&#37;A0&#37;EC&#37;84&#37;9C_&#37;EC&#37;86&#37;94&#37;EB&#37;A3&#37;A8&#37;EC&#37;85&#37;98&#37;ED&#37;8C&#37;80',
      'pjh*****',
      's2*******s2@',
      'https://ezkhuman.bizmeka.com/product/outlnk.do?code=PJ02&',
      '//출근',
      // buttonTitle+'[완료]',
      buttonTitle,
    ];
    itemsLength = items.length;
    itemsSnapshotAtStart = [...items]; //이것도 items 를 참조하는 것 때문에 문제가 되는 것 같기도함..
    itemsIterable = IterableStringListMaker(items: items);
  }

  
  void onToogleIsChecked() {
    setState(() {
      if (isChecked == true) {
        isChecked = false;
      } else {
        isChecked = true;
      }
      storage.setItem('isChecked202307041308', isChecked);
    });
  }

  
  void initIsChecked() {
    setState(() {
      if (storage.getItem('isChecked202307041308') == null) {
        isChecked = false;
        storage.setItem('isChecked202307041308', isChecked);
      } else {
        isChecked = storage.getItem('isChecked202307041308');
      }
    });
  }
}