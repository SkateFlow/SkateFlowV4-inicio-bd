# Sistema de Design SkateFlow

Este documento descreve o sistema de design implementado no SkateFlowV4, baseado na identidade visual do skateflow-web.

## Paleta de Cores

### Cores Principais
- **Primary Blue**: `#3888D2` - Cor principal da marca
- **Dark Blue**: `#043C70` - Versão mais escura do azul principal
- **Navy Blue**: `#00294F` - Azul marinho para fundos
- **Dark Navy**: `#001426` - Azul marinho escuro
- **Deep Dark**: `#010A12` - Azul muito escuro
- **Card Dark**: `#08243E` - Cor para cards em modo escuro
- **Footer Dark**: `#272727` - Cor do rodapé
- **Hover Green**: `#01bf71` - Verde para estados de hover

### Gradientes
- **Primary Gradient**: Linear gradient do Primary Blue para Dark Blue
- **Background Gradient**: Gradient complexo usando tons de azul marinho

## Tipografia

### Fonte Principal
- **Lexend**: Fonte principal do sistema, importada do Google Fonts
- Pesos disponíveis: 300, 400, 500, 600, 700, 800, 900

### Hierarquia de Tamanhos
- **Hero**: 48px - Títulos principais
- **H1**: 24px - Títulos de seção
- **H2**: 20px - Subtítulos
- **Body Large**: 18px - Texto principal grande
- **Body Medium**: 16px - Texto padrão
- **Body Small**: 14px - Texto secundário

## Componentes

### SkateButton
Botão personalizado com as seguintes variações:
- **Primary**: Botão principal com cor azul
- **Outlined**: Botão com borda
- **Large**: Versão maior do botão
- **With Icon**: Botão com ícone

### SkateGradientButton
Botão com gradiente, seguindo o design do site web.

### SkateCard
Card personalizado com:
- Bordas arredondadas (12px)
- Sombra sutil
- Opção de borda com gradiente
- Suporte a modo claro e escuro

### EventCard
Card específico para eventos, replicando o design do site web:
- Borda com gradiente
- Layout específico para informações do evento
- Ícones contextuais

### SkateAppBar
AppBar personalizado com:
- Gradiente de fundo
- Fonte Lexend
- Suporte a scroll effects

## Espaçamentos

### Padding
- **Small**: 8px
- **Medium**: 16px
- **Large**: 24px
- **XLarge**: 32px

### Margins
- **Small**: 8px
- **Medium**: 16px
- **Large**: 24px

### Border Radius
- **Small**: 8px
- **Medium**: 12px
- **Large**: 20px
- **Button**: 50px (bordas arredondadas completas)

## Elevações

- **Low**: 2dp - Cards simples
- **Medium**: 4dp - Botões e elementos interativos
- **High**: 8dp - Modais e elementos flutuantes

## Animações

### Durações
- **Fast**: 200ms - Transições rápidas
- **Medium**: 300ms - Transições padrão
- **Slow**: 500ms - Transições complexas

### Curvas
- **Default**: `Curves.easeInOut`
- **Fast**: `Curves.easeOut`
- **Slow**: `Curves.easeInOutCubic`

## Responsividade

### Breakpoints
- **Mobile**: < 480px
- **Tablet**: 480px - 768px
- **Desktop**: 768px - 1024px
- **Large Desktop**: > 1024px

## Modo Escuro

O sistema suporta modo escuro com:
- Fundo principal: `#202020`
- Cards: `#2C2C2C`
- Texto: Branco com variações de opacidade
- Cores de destaque mantidas (azuis)

## Como Usar

### 1. Importar o Tema
```dart
import 'theme/app_theme.dart';
```

### 2. Aplicar no MaterialApp
```dart
MaterialApp(
  theme: AppTheme.lightTheme,
  darkTheme: AppTheme.darkTheme,
  // ...
)
```

### 3. Usar Componentes
```dart
// Botão
SkateButton(
  text: 'Entrar',
  onPressed: () {},
  isPrimary: true,
)

// Card
SkateCard(
  hasGradientBorder: true,
  child: Text('Conteúdo'),
)

// AppBar
SkateAppBar(
  title: 'SkateFlow',
  actions: [...],
)
```

### 4. Usar Constantes
```dart
import 'theme/app_constants.dart';

Container(
  padding: EdgeInsets.all(AppConstants.paddingMedium),
  borderRadius: BorderRadius.circular(AppConstants.borderRadiusMedium),
)
```

## Próximos Passos

1. **Fontes**: Baixar e adicionar os arquivos de fonte Lexend na pasta `fonts/`
2. **Ícones**: Considerar ícones personalizados para skate
3. **Ilustrações**: Adicionar ilustrações consistentes com o tema
4. **Animações**: Implementar micro-interações
5. **Acessibilidade**: Garantir contraste adequado e suporte a leitores de tela

## Referências

- Design baseado no skateflow-web
- Material Design 3 guidelines
- Flutter best practices
- Lexend font family