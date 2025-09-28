# Instruções de Configuração - SkateFlow

## Configuração Automática (Recomendado)

Após clonar o projeto do GitHub, execute:

```bash
# Windows
setup_project.bat

# Ou manualmente:
flutter clean
flutter pub get
python fix_errors.py
flutter analyze
```

## Problemas Comuns e Soluções

### 1. Dependências Desatualizadas
- **Problema**: Mensagens sobre pacotes com versões mais novas
- **Solução**: Já corrigido no pubspec.yaml atualizado

### 2. Erros de API do Flutter
- **Problema**: `withValues` não existe, `activeThumbColor` depreciado
- **Solução**: Execute `python fix_errors.py`

### 3. Visual Studio Components
- **Problema**: Componentes C++ faltando
- **Solução**: Instale "Desktop development with C++" no Visual Studio

### 4. Cache Corrompido
- **Problema**: Erros estranhos após clone
- **Solução**: Execute `flutter clean` antes de `flutter pub get`

## Configuração Permanente

Para evitar problemas futuros:

1. **Sempre execute após clonar**:
   ```bash
   flutter clean && flutter pub get
   ```

2. **Mantenha dependências atualizadas**:
   ```bash
   flutter pub outdated
   flutter pub upgrade
   ```

3. **Use o script fix_errors.py** quando houver mudanças na API do Flutter

## Estrutura do Projeto

- `lib/` - Código principal do app
- `assets/` - Imagens e recursos
- `test/` - Testes unitários
- `fix_errors.py` - Script para corrigir erros de API
- `setup_project.bat` - Configuração automática