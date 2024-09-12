import 'package:flutter/material.dart';

class CurrencyAppMaterialPage extends StatefulWidget {
  const CurrencyAppMaterialPage({super.key});

  @override
  State<CurrencyAppMaterialPage> createState() =>
      CurrencyAppMaterialPageState();
}

class CurrencyAppMaterialPageState extends State<CurrencyAppMaterialPage> {
  double result = 0;
  final TextEditingController textEditingController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void convert() {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        result = double.parse(textEditingController.text) * 15.46;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderSide: const BorderSide(
          color: Colors.black, width: 2, style: BorderStyle.solid),
      borderRadius: BorderRadius.circular(5),
    );

    return MaterialApp(
      theme: ThemeData(
        textTheme: const TextTheme(
          headlineSmall: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 1, 170, 255),
          title: const Text(
            'Currency Converter',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.info),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('About'),
                    content: const Text('This app converts USD to GHS.'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
        body: SafeArea(
          child: OrientationBuilder(
            builder: (context, orientation) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'USD to GHS Converter',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      SizedBox(
                        height: 100,
                        child: orientation == Orientation.portrait
                            ? Image.asset('assets/currency.png')
                            : Image.asset('assets/currency.png'),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'GHS ${result != 0 ? result.toStringAsFixed(2) : result.toStringAsFixed(0)}',
                          style: const TextStyle(
                            fontSize: 55,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: textEditingController,
                              style: const TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                hintText: 'Enter amount in USD',
                                hintStyle: const TextStyle(color: Colors.black),
                                prefixIcon: const Icon(Icons.monetization_on),
                                prefixIconColor: Colors.black,
                                filled: true,
                                fillColor: Colors.white,
                                focusedBorder: border,
                                enabledBorder: border,
                              ),
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                      decimal: true),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter an amount';
                                }
                                if (double.tryParse(value) == null) {
                                  return 'Please enter a valid number';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: convert,
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.black,
                                foregroundColor: Colors.white,
                                minimumSize: const Size(double.infinity, 50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: const Text('Convert'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              result = 0;
              textEditingController.clear();
            });
          },
          backgroundColor: Colors.blue,
          child: const Icon(Icons.refresh),
        ),
      ),
    );
  }
}
