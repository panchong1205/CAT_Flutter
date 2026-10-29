#!/bin/bash
set -e
echo "Building CAT Tablet Console..."
cd "$(dirname "$0")/../apps/cat_tablet"
flutter build web --release
echo "Tablet console build complete: apps/cat_tablet/build/web/"