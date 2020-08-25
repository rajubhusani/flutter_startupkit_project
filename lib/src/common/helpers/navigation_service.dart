import 'package:flutter/material.dart';

final NavigationService navService = NavigationService();

class NavigationService<T, U> {
  static GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();

  Future<T> pushNamed(String routeName, {Object args}) async =>
      await navigationKey.currentState.pushNamed<T>(
        routeName,
        arguments: args,
      );

  Future<T> push(Route<T> route) async =>
      await navigationKey.currentState.push<T>(route);

  Future<T> pushReplacementNamed(String routeName, {Object args}) async =>
      await navigationKey.currentState.pushReplacementNamed<T, U>(
        routeName,
        arguments: args,
      );

  Future<T> pushAndRemoveUntil(
          Route<T> newRoute, RoutePredicate predicate) async =>
      await navigationKey.currentState.pushAndRemoveUntil(newRoute, predicate);

  Future<T> pushNamedAndRemoveUntil(String routeName, RoutePredicate predicate,
          {Object args}) async =>
      await navigationKey.currentState.pushNamedAndRemoveUntil<T>(
        routeName,
        predicate,
        arguments: args,
      );

  Future<bool> maybePop([Object args]) async =>
      await navigationKey.currentState.maybePop<Object>(args);

  bool canPop() => navigationKey.currentState.canPop();

  void pop({T result}) => navigationKey.currentState.pop<T>(result);

  Future<T> popAndPushNamed(String route, {Object args}) async =>
      await navigationKey.currentState.popAndPushNamed(route, arguments: args);

  void popUntil(RoutePredicate route) =>
      navigationKey.currentState.popUntil(route);
}
