#!/bin/bash

# Setup GitHub Pages for Helm repository
# This script creates the gh-pages branch and sets up the Helm repository index

set -e

echo "Setting up GitHub Pages for Helm repository..."

# Create gh-pages branch
git checkout --orphan gh-pages

# Remove all files except the chart
rm -rf .github/
rm -rf scripts/
rm -rf templates/
rm -f Chart.yaml
rm -f values.yaml
rm -f README.md
rm -f .helmignore

# Package the chart
helm package ../docmost/

# Create index.yaml
helm repo index . --url https://$(git config --get remote.origin.url | sed 's/.*github.com[:/]\([^/]*\)\/\([^.]*\).*/\1.github.io\/\2/')

# Commit and push
git add .
git commit -m "Add Helm chart package and index"
git push origin gh-pages

# Switch back to main branch
git checkout main

echo "GitHub Pages setup complete!"
echo "Don't forget to enable GitHub Pages in your repository settings:"
echo "1. Go to Settings → Pages"
echo "2. Source: Deploy from a branch"
echo "3. Branch: gh-pages"
echo "4. Save" 