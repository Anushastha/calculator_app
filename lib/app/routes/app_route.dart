import 'package:calculatorapp/view/calculator_view.dart';

class AppRoute{
  AppRoute._();

  static const String calculatorRoute = '/calculator';


  static getApplicationRoute(){
    return{
      calculatorRoute: (context) => CalculatorView(),

    };
  }
}