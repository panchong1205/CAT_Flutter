#!/bin/bash
set -e
echo "Building CAT Vehicle Terminal..."
cd "$(dirname "$0")/../apps/cat_vehicle"
flutter build web --release
echo "Vehicle terminal build complete: apps/cat_vehicle/build/web/"