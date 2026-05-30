@echo off
set FLUTTER=C:\Users\ELKIN_MOYON\fvm\versions\3.35.0\bin\flutter.bat
echo =^> flutter pub get...
call "%FLUTTER%" pub get
echo =^> Generando env.g.dart...
call "%FLUTTER%" pub run build_runner build --delete-conflicting-outputs
echo =^> Listo!
