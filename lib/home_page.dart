import 'dart:math';
import 'package:bmi_calculator/result.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isMale = true;
  double heightVal = 150;
  int weight = 55;
  int age = 18;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Body Mass Index"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    buildGestureDetector(context, "Meal", Icons.male),
                    const SizedBox(
                      width: 5,
                    ),
                    Flexible(
                        child: buildGestureDetector(
                            context, "Female", Icons.female)),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blueGrey),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Height",
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          heightVal.toStringAsFixed(1),
                          style: Theme.of(context).textTheme.headline2,
                        ),
                        Text(
                          "cm",
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ],
                    ),
                    Slider(
                        min: 90,
                        max: 220,
                        value: heightVal,
                        onChanged: (val) {
                          setState(() {
                            heightVal = val;
                          });
                        })
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(child: buildContainer(context, "weight")),
                    const SizedBox(
                      width: 5,
                    ),
                    Flexible(child: buildContainer(context, "age")),
                  ],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 14,
              color: Colors.teal,
              child: TextButton(
                onPressed: () {
                  var result = weight / pow(heightVal / 100, 2);
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Result(
                            result: result,
                            isMale: isMale,
                            age: age,
                          )));
                },
                child: Text(
                  "Calculate",
                  style: Theme.of(context).textTheme.headline2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  GestureDetector buildGestureDetector(
      BuildContext context, String txt, IconData icon) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isMale = (txt == "Meal") ? true : false;
        });
      },
      child: Container(
        width: MediaQuery.of(context).size.width / 2,
        decoration: BoxDecoration(
            color: (isMale && txt == "Meal") || (!isMale && txt == "Female")
                ? Colors.teal
                : Colors.blueGrey,
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            Icon(
              icon,
              size: 90,
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              txt,
              style: Theme.of(context).textTheme.headline2,
            )
          ],
        ),
      ),
    );
  }

  Container buildContainer(BuildContext context, String txt) {
    return Container(
      width: MediaQuery.of(context).size.width / 2,
      decoration: BoxDecoration(
          color: Colors.blueGrey, borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          //  Icon(icon),

          Text(
            txt == "age" ? "Age" : "Weight",
            style: Theme.of(context).textTheme.headline2,
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            txt == "age" ? "$age" : "$weight",
            style: Theme.of(context).textTheme.headline1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FloatingActionButton(
                onPressed: () {
                  setState(() {
                    txt == "age" ? age-- : weight--;
                  });
                },
                heroTag: txt == "age" ? "age--" : "weight--",
                mini: true,
                child: const Icon((Icons.remove)),
              ),
              const SizedBox(
                width: 8,
              ),
              FloatingActionButton(
                onPressed: () {
                  setState(() {
                    txt == "age" ? age++ : weight++;
                  });
                },
                heroTag: txt == "age" ? "age++" : "weight++",
                mini: true,
                child: const Icon((Icons.add)),
              )
            ],
          ),
        ],
      ),
    );
  }
}
