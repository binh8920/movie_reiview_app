import 'package:flutter/material.dart';
import '../../../apis/apis.dart';
import '../../app.dart';
import '../../../shared_widgets/custom_grid_view_widget.dart';
import '../../../shared_widgets/custom_value.dart';
import '../../../shared_widgets/custom_widgets.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({Key? key}) : super(key: key);

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'MODE',
            style: TextStyle(color: uppermodecolor, fontSize: 20),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    canvasmodecolor = Colors.white54;
                    uppermodecolor = lightmode;
                    oppositecolor = Colors.white70;
                    selectedbackimg = backimage[0];
                  });
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MainScreen(index: 2),
                    ),
                  );
                },
                child: Container(
                  height: 40,
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.white38,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Center(
                    child: Text(
                      'LIGHT MODE',
                      style: TextStyle(fontSize: 15, color: uppermodecolor),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    canvasmodecolor = Colors.black54;
                    uppermodecolor = darkmode;
                    oppositecolor = Colors.black54;
                    selectedbackimg = backimage[1];
                  });
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MainScreen(
                              index: 2,
                            )),
                  );
                },
                child: Container(
                  height: 40,
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.white38,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Center(
                    child: Text(
                      'DARK MODE',
                      style: TextStyle(fontSize: 15, color: uppermodecolor),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
