#!/Users/baaden/.venv/myenv/bin/python3

from PIL import Image
import math

BASEIMAGE='img/circuit1t.png'

def tile_image_to_aspect(input_path, output_path, target_ratio_height_over_width):
    # Ouvrir l'image source
    img = Image.open(input_path)
    w, h = img.size

    # Calcul de la hauteur cible basée sur la largeur actuelle
    target_height = int(w * target_ratio_height_over_width)

    # Nombre de répétitions nécessaires
    num_repeats = math.ceil(target_height / h)

    # Créer une nouvelle image assez haute
    result = Image.new('RGBA', (w, h * num_repeats))

    for i in range(num_repeats):
        result.paste(img, (0, i * h))

    # Recadrer à la hauteur exacte
    final = result.crop((0, 0, w, target_height))

    # Sauvegarder l’image finale
    final.save(output_path)
    print(f"Saved: {output_path} — Size: {final.size}")

# Exemple d’usage
tile_image_to_aspect(
    input_path=BASEIMAGE,
    output_path='img/tiled_13.png',
    target_ratio_height_over_width=13 / 3  # Pour une image de 3cm × 13cm
)
tile_image_to_aspect(
    input_path=BASEIMAGE,
    output_path='img/tiled_9.png',
    target_ratio_height_over_width=9 / 3  # Pour une image de 3cm × 13cm
)
tile_image_to_aspect(
    input_path=BASEIMAGE,
    output_path='img/tiled_4.png',
    target_ratio_height_over_width=3 / 3  # Pour une image de 3cm × 13cm
)
tile_image_to_aspect(
    input_path=BASEIMAGE,
    output_path='img/tiled_119.png',
    target_ratio_height_over_width=130 / 3  # Pour une image de 3cm × 13cm
)

