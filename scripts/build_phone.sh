#!/bin/bash
set -e
echo "Building CAT Phone Dashboard..."
cd "$(dirname "$0")/../apps/cat_phone"
flutter build web --release
echo "Phone dashboard build complete: apps/cat_phone/build/web/"