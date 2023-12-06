import 'package:flutter/material.dart';
import 'package:hive_with_adapter/database/db.dart';

class Containercard extends StatelessWidget {
  Containercard(
      {super.key,
      required this.title,
      required this.description,
      required this.date,
      required this.color,
      this.ondeleteTap,
      this.onedittap});
  String title;
  String description;
  String date;
  int color;
  final void Function()? ondeleteTap;
  final void Function()? onedittap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(35),
        decoration: BoxDecoration(
            color: database.colors[color].withOpacity(.7),
            borderRadius: BorderRadius.circular(20)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title.toUpperCase(),
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  maxLines: 2,
                ),
                Row(
                  children: [
                    Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                            border: Border.all(width: 0.5, color: Colors.black),
                            borderRadius: BorderRadius.circular(8)),
                        child:
                            InkWell(onTap: onedittap, child: Icon(Icons.edit))),
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                            border: Border.all(width: 0.5, color: Colors.black),
                            borderRadius: BorderRadius.circular(8)),
                        child: InkWell(
                            onTap: ondeleteTap, child: Icon(Icons.delete)))
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              description,
              maxLines: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  date,
                  maxLines: 1,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
