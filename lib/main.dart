import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uas_pemo_2009106031/controllers/product_controller.dart';
import 'package:uas_pemo_2009106031/views/homepage.dart';

void main() {
  runApp(const MyApp());
}

final _formKey = GlobalKey<FormState>();

class MyApp extends StatelessWidget {
  static final ValueNotifier<ThemeMode> themeNotifier =
      ValueNotifier(ThemeMode.light);
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
        valueListenable: themeNotifier,
        builder: (_, ThemeMode currentMode, __) {
          return MaterialApp(
            title: 'UAS Mobile 2009106031',
            theme: ThemeData(primarySwatch: Colors.blue),
            themeMode: currentMode,
            darkTheme: ThemeData(
              scaffoldBackgroundColor: Colors.grey.shade900,
              colorScheme: const ColorScheme.dark(),
              appBarTheme: const AppBarTheme(
                backgroundColor: Colors.black,
              ),
            ),
            debugShowCheckedModeBanner: false,
            home: const LandingPage(),
          );
        });
  }
}

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ProductController controllerNama = Get.put(ProductController());
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
        appBar: AppBar(
          title: const Text("UAS Mobile Gading 2009106031"),
          centerTitle: true,
          actions: [
            IconButton(
                icon: Icon(MyApp.themeNotifier.value == ThemeMode.light
                    ? Icons.dark_mode
                    : Icons.light_mode),
                onPressed: () {
                  MyApp.themeNotifier.value =
                      MyApp.themeNotifier.value == ThemeMode.light
                          ? ThemeMode.dark
                          : ThemeMode.light;
                })
          ],
        ),
        body: Center(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                    width: 315,
                    child: Image.asset(
                      isDarkMode
                          ? 'assets/logo_maybelline.png'
                          : 'assets/logo_maybelline_black.png',
                      fit: BoxFit.cover,
                    )),
                SizedBox(
                  width: 332,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name, bro.';
                        }
                        return null;
                      },
                      controller: controllerNama.nameForm,
                      decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Name',
                          hintText: 'Fazri Rahmad Nor Gading'),
                    ),
                  ),
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: isDarkMode ? Colors.white : Colors.blue,
                        fixedSize: const Size(318, 40)),
                    onPressed: () {
                      final snackBar = SnackBar(
                        content: const Text(
                            'Selamat datang dan selamat berbelanja.'),
                        action: SnackBarAction(
                          label: 'Tau ay.',
                          onPressed: () {},
                        ),
                      );
                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        controllerNama.updatename();
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                        );
                      }
                    },
                    child: const Text("Shop Now"))
              ],
            ),
          ),
        ));
  }
}
