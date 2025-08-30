#!/usr/bin/env python3
"""
Script para gerar ícones do app SkateFlow em diferentes tamanhos
Usa a logo preta como base e redimensiona para os tamanhos necessários
"""

from PIL import Image
import os

# Tamanhos necessários para Android
sizes = {
    'mipmap-mdpi': 48,
    'mipmap-hdpi': 72,
    'mipmap-xhdpi': 96,
    'mipmap-xxhdpi': 144,
    'mipmap-xxxhdpi': 192
}

def generate_icons():
    # Caminho para a logo
    logo_path = "assets/images/skateparks/logo-preta.png"
    
    if not os.path.exists(logo_path):
        print(f"Logo não encontrada em: {logo_path}")
        return
    
    # Abrir a logo original
    try:
        logo = Image.open(logo_path)
        print(f"Logo carregada: {logo.size}")
        
        # Converter para RGBA se necessário
        if logo.mode != 'RGBA':
            logo = logo.convert('RGBA')
        
        # Gerar ícones para cada tamanho
        for folder, size in sizes.items():
            # Redimensionar mantendo proporção
            resized = logo.resize((size, size), Image.Resampling.LANCZOS)
            
            # Caminho de destino
            output_dir = f"android/app/src/main/res/{folder}"
            os.makedirs(output_dir, exist_ok=True)
            
            output_path = f"{output_dir}/ic_launcher.png"
            
            # Salvar o ícone
            resized.save(output_path, "PNG")
            print(f"Ícone gerado: {output_path} ({size}x{size})")
            
        print("Todos os ícones foram gerados com sucesso!")
        
    except Exception as e:
        print(f"Erro ao processar logo: {e}")

if __name__ == "__main__":
    generate_icons()