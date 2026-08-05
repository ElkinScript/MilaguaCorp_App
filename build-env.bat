@echo off
if "%FLUTTER%"=="" set FLUTTER=flutter
echo =^> flutter pub get...
call "%FLUTTER%" pub get
echo =^> Generando env.g.dart...
call "%FLUTTER%" pub run build_runner build --delete-conflicting-outputs
echo =^> Listo!
