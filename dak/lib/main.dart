import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert'; // jsonDecode ishlatish uchun kerak

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int hisAge = 34; // "HIS AGE" uchun boshlang'ich qiymat

  void _showAgeDialog() {
    TextEditingController ageController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: TextField(
            controller: ageController,
            keyboardType: TextInputType.number,
            maxLength: 2,
            decoration: InputDecoration(
              hintText: "Enter age ",
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Dialogni yopish
              },
              child: Text("back"),
            ),
            ElevatedButton(
              onPressed: () {
                if (ageController.text.isNotEmpty) {
                  int? enteredAge = int.tryParse(ageController.text);
                  if (enteredAge != null &&
                      enteredAge > 0 &&
                      enteredAge <= 99) {
                    setState(() {
                      hisAge = enteredAge; // Yangi yoshni o‘rnatish
                    });
                    Navigator.of(context).pop(); // Dialogni yopish
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Saved successfully!")),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text("Please enter a valid age (1-99).")),
                    );
                  }
                }
              },
              child: Text("ok"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                // Lottie animatsiyasiga bosilganda boshqa sahifaga o‘ting
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SecondScreen()),
                );
              },
              child: GestureDetector(
                  onTap: () {
                    print("chiqdi");
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CurrencyScreen(),
                        ));
                  },
                  child: Container(
                    width: 50,
                    height: 50,
                    child: Image.asset("rasm/dollor.png"),
                  )),
            ),
          ),
          title: ShaderMask(
            shaderCallback: (bounds) {
              return LinearGradient(
                colors: [
                  const Color.fromARGB(255, 2, 15, 74),
                  const Color.fromARGB(255, 39, 53, 176),
                  const Color.fromARGB(255, 7, 74, 28)
                ],
              ).createShader(bounds);
            },
            child: Center(
              child: Text(
                'flutter',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          actions: [
            GestureDetector(
              onTap: _showAgeDialog,
              child: Lottie.asset(
                'lottie/sal.json',
                fit: BoxFit.cover, // Lottie animatsiyasining joylashuvi
              ),
            ),
          ],
        ),
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "HIS AGE",
                    style: TextStyle(
                        color: const Color.fromARGB(255, 118, 118, 118),
                        fontWeight: FontWeight.w900),
                  ),
                  Text(
                    "$hisAge/100",
                    style: TextStyle(
                        fontSize: 20,
                        color: const Color.fromARGB(255, 78, 78, 78),
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "OVERALL",
                    style: TextStyle(
                      color: const Color.fromARGB(255, 118, 118, 118),
                    ),
                  ),
                  SizedBox(
                    height: 13,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.favorite_outlined,
                            color: Colors.red,
                          ),
                          Text("34"),
                          Text(
                            "/100",
                            style: TextStyle(
                              fontSize: 10,
                              color: const Color.fromARGB(255, 118, 118, 118),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 27, bottom: 5),
                        child: Text(
                          "Energy",
                          style: TextStyle(fontSize: 10),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 13,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage("rasm/gg.png"))),
                          ),
                          Text("24"),
                          Text(
                            "/100",
                            style: TextStyle(
                              fontSize: 10,
                              color: const Color.fromARGB(255, 118, 118, 118),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30, bottom: 5),
                        child: Text(
                          "smart",
                          style: TextStyle(fontSize: 10),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 13,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 30,
                            height: 30,
                            child: Icon(
                              Icons.flash_on,
                              color: Colors.yellow,
                            ),
                          ),
                          Text("54"),
                          Text(
                            "/100",
                            style: TextStyle(
                              fontSize: 10,
                              color: const Color.fromARGB(255, 118, 118, 118),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30, bottom: 5),
                        child: Text(
                          "speed",
                          style: TextStyle(fontSize: 10),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Positioned(
                top: 200,
                left: 260,
                child: Transform(
                  transform: Matrix4.rotationZ(0.1), // Qiyshaytirish burchagi
                  alignment: Alignment.center,
                  child: Container(
                    width: 200,
                    height: 200,
                    child: Lottie.asset('lottie/salom.json', fit: BoxFit.cover),
                  ),
                )),
            Positioned(
              left: 270,
              child: Container(
                  width: 200,
                  height: 320,
                  child: Image.asset(
                    "rasm/ol.png",
                    fit: BoxFit.cover,
                  )),
            ),
            Positioned(
              bottom: 20,
              left: 16,
              right: 16,
              child: CarouselSlider(
                options: CarouselOptions(
                  height: 200,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 4),
                  enlargeCenterPage: true,
                  viewportFraction: 0.8,
                ),
                items: [
                  'rasm/q1.png', // Rasmlar manzillari
                  'rasm/q2.png',
                  'rasm/q3.png',
                  'rasm/q4.png',
                  'rasm/q5.png', // Rasmlar manzillari
                  'rasm/q6.png',
                  'rasm/q12.png',
                  'rasm/q13.png',
                  'rasm/q14.png',
                  'rasm/q16.png',
                  'rasm/q19.png',
                  'rasm/q20.png',
                  'rasm/q21.png',
                  'rasm/q22.png',
                  'rasm/q28.png',
                ].map((item) {
                  return ClipRRect(
                    borderRadius:
                        BorderRadius.circular(20), // Kesilgan borderlar
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 8),
                      child: Image.asset(
                        item,
                        fit: BoxFit.cover,
                        width: 1000, // Container kengligi
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Second Screen')),
      body: Center(
        child: Text('This is the second screen!'),
      ),
    );
  }
}

class CurrencyScreen extends StatefulWidget {
  @override
  _CurrencyScreenState createState() => _CurrencyScreenState();
}

class _CurrencyScreenState extends State<CurrencyScreen> {
  late Future<List<Currency>> futureCurrencies;

  @override
  void initState() {
    super.initState();
    futureCurrencies = fetchCurrencies();
  }

  Future<List<Currency>> fetchCurrencies() async {
    final response = await http
        .get(Uri.parse('https://cbu.uz/uz/arkhiv-kursov-valyut/json/'));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => Currency.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load currency data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Valyuta kurslari",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue[800],
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                "${DateTime.now().toString().substring(0, 10)}",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
      body: FutureBuilder<List<Currency>>(
        future: futureCurrencies,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data available'));
          } else {
            final currencies = snapshot.data!;
            return ListView.builder(
              itemCount: currencies.length,
              itemBuilder: (context, index) {
                final currency = currencies[index];
                String changeText = currency.change >= 0
                    ? '+${currency.change.toStringAsFixed(2)}'
                    : '${currency.change.toStringAsFixed(2)}';
                Color changeColor =
                    currency.change >= 0 ? Colors.green : Colors.red;

                return Container(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        blurRadius: 6,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              currency.name,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue[800],
                              ),
                            ),
                            Text(
                              "(${currency.code})",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "1 ${currency.code}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              currency.rate.toStringAsFixed(2),
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "updated day\n${currency.date}",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                            Text(
                              changeText,
                              style: TextStyle(
                                fontSize: 16,
                                color: changeColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

class Currency {
  final String code;
  final String name;
  final double rate;
  final String date;
  final double change;

  Currency({
    required this.code,
    required this.name,
    required this.rate,
    required this.date,
    required this.change,
  });

  factory Currency.fromJson(Map<String, dynamic> json) {
    return Currency(
      code: json['Ccy'],
      name: json['CcyNm_UZ'],
      rate: double.parse(json['Rate']),
      date: json['Date'],
      change: double.parse(json['Diff']),
    );
  }
}
