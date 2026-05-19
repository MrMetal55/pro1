from pathlib import Path

from PIL import Image


ROOT = Path(__file__).resolve().parents[1]
SOURCE_IMAGE = ROOT / "assets" / "app_logo_source.png"
MASTER = ROOT / "assets" / "logo_rose_equal_1024.png"


def load_source():
    source = Image.open(SOURCE_IMAGE).convert("RGBA")
    width, height = source.size
    side = min(width, height)
    left = (width - side) // 2
    top = (height - side) // 2
    return source.crop((left, top, left + side, top + side))


def save_png(source, path, size):
    path.parent.mkdir(parents=True, exist_ok=True)
    resized = source.resize((size, size), Image.Resampling.LANCZOS)
    resized.convert("RGB").save(path)


def main():
    source = load_source()
    save_png(source, MASTER, 1024)

    ios_sizes = {
        "Icon-App-20x20@1x.png": 20,
        "Icon-App-20x20@2x.png": 40,
        "Icon-App-20x20@3x.png": 60,
        "Icon-App-29x29@1x.png": 29,
        "Icon-App-29x29@2x.png": 58,
        "Icon-App-29x29@3x.png": 87,
        "Icon-App-40x40@1x.png": 40,
        "Icon-App-40x40@2x.png": 80,
        "Icon-App-40x40@3x.png": 120,
        "Icon-App-60x60@2x.png": 120,
        "Icon-App-60x60@3x.png": 180,
        "Icon-App-76x76@1x.png": 76,
        "Icon-App-76x76@2x.png": 152,
        "Icon-App-83.5x83.5@2x.png": 167,
        "Icon-App-1024x1024@1x.png": 1024,
    }
    for name, size in ios_sizes.items():
        save_png(
            source,
            ROOT / "ios" / "Runner" / "Assets.xcassets" / "AppIcon.appiconset" / name,
            size,
        )

    mac_sizes = {
        "app_icon_16.png": 16,
        "app_icon_32.png": 32,
        "app_icon_64.png": 64,
        "app_icon_128.png": 128,
        "app_icon_256.png": 256,
        "app_icon_512.png": 512,
        "app_icon_1024.png": 1024,
    }
    for name, size in mac_sizes.items():
        save_png(
            source,
            ROOT / "macos" / "Runner" / "Assets.xcassets" / "AppIcon.appiconset" / name,
            size,
        )

    android_sizes = {
        "mipmap-mdpi": 48,
        "mipmap-hdpi": 72,
        "mipmap-xhdpi": 96,
        "mipmap-xxhdpi": 144,
        "mipmap-xxxhdpi": 192,
    }
    for folder, size in android_sizes.items():
        save_png(
            source,
            ROOT / "android" / "app" / "src" / "main" / "res" / folder / "ic_launcher.png",
            size,
        )

    save_png(source, ROOT / "web" / "favicon.png", 32)
    save_png(source, ROOT / "web" / "icons" / "Icon-192.png", 192)
    save_png(source, ROOT / "web" / "icons" / "Icon-maskable-192.png", 192)
    save_png(source, ROOT / "web" / "icons" / "Icon-512.png", 512)
    save_png(source, ROOT / "web" / "icons" / "Icon-maskable-512.png", 512)

    ico_path = ROOT / "windows" / "runner" / "resources" / "app_icon.ico"
    ico_path.parent.mkdir(parents=True, exist_ok=True)
    source.convert("RGB").save(
        ico_path,
        sizes=[(16, 16), (32, 32), (48, 48), (64, 64), (128, 128), (256, 256)],
    )


if __name__ == "__main__":
    main()
