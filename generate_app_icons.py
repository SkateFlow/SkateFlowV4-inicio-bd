from PIL import Image
import os

def generate_icons():
    # Caminho da logo original
    logo_path = "assets/images/skateparks/logo-preta.png"
    
    if not os.path.exists(logo_path):
        print(f"Logo não encontrada em {logo_path}")
        return
    
    # Abrir a logo original
    logo = Image.open(logo_path)
    
    # Tamanhos para Android
    android_sizes = [
        (48, "android/app/src/main/res/mipmap-mdpi"),
        (72, "android/app/src/main/res/mipmap-hdpi"),
        (96, "android/app/src/main/res/mipmap-xhdpi"),
        (144, "android/app/src/main/res/mipmap-xxhdpi"),
        (192, "android/app/src/main/res/mipmap-xxxhdpi")
    ]
    
    # Tamanhos para iOS
    ios_sizes = [
        (20, "ios/Runner/Assets.xcassets/AppIcon.appiconset", "Icon-App-20x20@1x.png"),
        (40, "ios/Runner/Assets.xcassets/AppIcon.appiconset", "Icon-App-20x20@2x.png"),
        (60, "ios/Runner/Assets.xcassets/AppIcon.appiconset", "Icon-App-20x20@3x.png"),
        (29, "ios/Runner/Assets.xcassets/AppIcon.appiconset", "Icon-App-29x29@1x.png"),
        (58, "ios/Runner/Assets.xcassets/AppIcon.appiconset", "Icon-App-29x29@2x.png"),
        (87, "ios/Runner/Assets.xcassets/AppIcon.appiconset", "Icon-App-29x29@3x.png"),
        (40, "ios/Runner/Assets.xcassets/AppIcon.appiconset", "Icon-App-40x40@1x.png"),
        (80, "ios/Runner/Assets.xcassets/AppIcon.appiconset", "Icon-App-40x40@2x.png"),
        (120, "ios/Runner/Assets.xcassets/AppIcon.appiconset", "Icon-App-40x40@3x.png"),
        (120, "ios/Runner/Assets.xcassets/AppIcon.appiconset", "Icon-App-60x60@2x.png"),
        (180, "ios/Runner/Assets.xcassets/AppIcon.appiconset", "Icon-App-60x60@3x.png"),
        (76, "ios/Runner/Assets.xcassets/AppIcon.appiconset", "Icon-App-76x76@1x.png"),
        (152, "ios/Runner/Assets.xcassets/AppIcon.appiconset", "Icon-App-76x76@2x.png"),
        (167, "ios/Runner/Assets.xcassets/AppIcon.appiconset", "Icon-App-83.5x83.5@2x.png"),
        (1024, "ios/Runner/Assets.xcassets/AppIcon.appiconset", "Icon-App-1024x1024@1x.png")
    ]
    
    # Gerar ícones Android
    for size, folder in android_sizes:
        os.makedirs(folder, exist_ok=True)
        resized = logo.resize((size, size), Image.Resampling.LANCZOS)
        resized.save(f"{folder}/ic_launcher.png")
        print(f"Gerado: {folder}/ic_launcher.png ({size}x{size})")
    
    # Gerar ícones iOS
    for size, folder, filename in ios_sizes:
        os.makedirs(folder, exist_ok=True)
        resized = logo.resize((size, size), Image.Resampling.LANCZOS)
        resized.save(f"{folder}/{filename}")
        print(f"Gerado: {folder}/{filename} ({size}x{size})")
    
    # Gerar ícones Web
    web_folder = "web/icons"
    os.makedirs(web_folder, exist_ok=True)
    
    web_sizes = [192, 512]
    for size in web_sizes:
        resized = logo.resize((size, size), Image.Resampling.LANCZOS)
        resized.save(f"{web_folder}/Icon-{size}.png")
        print(f"Gerado: {web_folder}/Icon-{size}.png ({size}x{size})")
    
    # Favicon
    favicon = logo.resize((32, 32), Image.Resampling.LANCZOS)
    favicon.save("web/favicon.png")
    print("Gerado: web/favicon.png (32x32)")
    
    print("\n✅ Todos os ícones foram gerados com sucesso!")
    print("Execute 'flutter clean && flutter pub get' para aplicar as mudanças.")

if __name__ == "__main__":
    generate_icons()