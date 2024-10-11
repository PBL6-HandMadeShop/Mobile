import 'package:rive/rive.dart';

class RiveAsset {
  final String artboard, stateMachineName, title, src;
  late SMIBool? input;

  RiveAsset(
    this.src, {
    required this.artboard,
    required this.stateMachineName,
    required this.title,
    this.input,
  });

  set setInput(SMIBool status) {
    input = status;
  }
}

List<RiveAsset> sideMenus = [
  RiveAsset(
    'asset/RiveAssets/icons.riv',
    artboard: 'HOME',
    stateMachineName: 'HOME_Interactivity',
    title: 'Home',
  ),
  RiveAsset(
    'asset/RiveAssets/icons.riv',
    artboard: 'SEARCH',
    stateMachineName: 'SEARCH_Interactivity',
    title: 'Search',
  ),
  RiveAsset(
    'asset/RiveAssets/icons.riv',
    artboard: 'CHAT',
    stateMachineName: 'CHAT_Interactivity',
    title: 'Chat',
  ),
];
List<RiveAsset> sideMenu2 = [
  RiveAsset(
    'asset/RiveAssets/icons.riv',
    artboard: 'TIMER',
    stateMachineName: 'TIMER_Interactivity',
    title: 'History',
  ),

];
List<RiveAsset> sideMenu3 = [
  RiveAsset(
    'asset/RiveAssets/icons.riv',
    artboard: 'SETTINGS',
    stateMachineName: 'SETTINGS_Interactivity',
    title: 'Settings',
  ),

];
