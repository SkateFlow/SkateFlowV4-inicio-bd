@echo off
echo Configurando projeto Flutter...

echo.
echo 1. Limpando cache do Flutter...
flutter clean

echo.
echo 2. Baixando dependencias...
flutter pub get

echo.
echo 3. Executando script de correcao de erros...
python fix_errors.py

echo.
echo 4. Analisando codigo...
flutter analyze

echo.
echo 5. Executando testes...
flutter test

echo.
echo Projeto configurado com sucesso!
pause