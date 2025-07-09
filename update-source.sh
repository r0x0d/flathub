#!/bin/bash

MANIFEST="community.awakenedpoetrade.AwakenedPoETrade.yml"
REPO="SnosMe/awakened-poe-trade"

# Get latest release tag
latest_tag=$(curl -s "https://api.github.com/repos/$REPO/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')

# Compose new filename and URL
filename="Awakened-PoE-Trade-${latest_tag#v}.AppImage"
url="https://github.com/$REPO/releases/download/$latest_tag/$filename"

echo "Latest release: $latest_tag"
echo "Download URL: $url"
echo "Downloading to calculate sha512..."
# Download the new AppImage to calculate sha512
@curl -L -o "$filename" "$url"
sha512=$(sha512sum "$filename" | awk '{print $1}')
rm "$filename"

# Update YAML file
sed -i -E \
    -e "s|(Awakened-PoE-Trade-)[0-9]+\.[0-9]+\.[0-9]+(\.AppImage)|\1${latest_tag#v}\2|g" \
    -e "s|(url: ).*|\1$url|" \
    -e "s|(sha512: ).*|\1$sha512|" \
    "$MANIFEST"

echo "Manifest updated with version $latest_tag and new sha512."