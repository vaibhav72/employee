import 'package:employee_app/cubits/employee_cubit/employee_cubit.dart';
import 'package:employee_app/repository/employee_repository.dart';
import 'package:employee_app/screens/employee_screens/employee_list_screen.dart';
import 'package:employee_app/screens/widgets/filter_widget.dart';
import 'package:employee_app/utils/helpers.dart';
import 'package:employee_app/utils/meta_colors.dart';
import 'package:employee_app/utils/meta_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var themeData = ThemeData(
      fontFamily: 'Montserrat',
      buttonTheme: ButtonThemeData(
          buttonColor: MetaColors.primaryColor.withOpacity(0.1),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(9),
              side: const BorderSide(color: MetaColors.primaryColor))),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: MetaColors.primaryColor),
      primaryColor: MetaColors.primaryColor,
      progressIndicatorTheme:
          const ProgressIndicatorThemeData(color: MetaColors.primaryColor),
      iconTheme: const IconThemeData(color: Colors.black),
      appBarTheme: AppBarTheme(
        actionsIconTheme: const IconThemeData(color: Colors.black),
        iconTheme: const IconThemeData(color: Colors.black),
        titleTextStyle: const TextStyle(
            color: Colors.black,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w600,
            fontSize: 20),
        elevation: 0,
        backgroundColor: Colors.white.withOpacity(0.5),
      ),
      backgroundColor: Colors.white.withOpacity(0.5),
    );
    return RepositoryProvider(
      create: (context) => EmployeeRepository(),
      child: BlocProvider(
        create: (context) =>
            EmployeeCubit(context.read<EmployeeRepository>())..loadEmployees(),
        child: MaterialApp(
          title: 'Employee App',
          theme: themeData,
          home: const MyHomePage(title: 'Home'),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: ((value) => setState(() {
                _currentIndex = value;
              })),
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile")
          ],
        ),
        body: _currentIndex == 0 ? const EmployeeList() : ProfileWidget());
  }
}

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Profile"),
        ),
        body: Center(child: Text('Hey admin Welcome')),
      ),
    );
  }
}
