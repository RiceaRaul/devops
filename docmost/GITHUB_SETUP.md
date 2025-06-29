# GitHub Repository Setup Guide

This guide explains how to set up your GitHub repository to distribute the Docmost Helm chart.

## Step 1: Initialize Git Repository

```bash
# Initialize git repository
git init

# Add all files
git add .

# Initial commit
git commit -m "Initial commit: Docmost Helm chart"

# Set main branch
git branch -M main

# Add remote origin (replace with your repository URL)
git remote add origin https://github.com/YOUR_USERNAME/YOUR_REPO.git

# Push to GitHub
git push -u origin main
```

## Step 2: Create GitHub Release

### Option A: Manual Release

1. Package the chart:
   ```bash
   helm package docmost/
   ```

2. Go to your GitHub repository
3. Click "Releases" in the right sidebar
4. Click "Create a new release"
5. Tag version: `v0.1.0`
6. Release title: `v0.1.0`
7. Upload the `docmost-0.1.0.tgz` file
8. Publish release

### Option B: Automated Release (Recommended)

The repository includes GitHub Actions workflows that automatically create releases when you push tags:

```bash
# Create and push a tag
git tag v0.1.0
git push origin v0.1.0
```

This will automatically:
- Package the Helm chart
- Create a GitHub release
- Upload the chart package

## Step 3: Set Up GitHub Pages (Optional)

To enable users to add your repository as a Helm repo:

### Option A: Using the Setup Script

```bash
# Run the setup script
./scripts/setup-gh-pages.sh
```

### Option B: Manual Setup

1. Create gh-pages branch:
   ```bash
   git checkout --orphan gh-pages
   ```

2. Package the chart:
   ```bash
   helm package ../docmost/
   ```

3. Create index.yaml:
   ```bash
   helm repo index . --url https://YOUR_USERNAME.github.io/YOUR_REPO
   ```

4. Commit and push:
   ```bash
   git add .
   git commit -m "Add Helm chart package and index"
   git push origin gh-pages
   ```

5. Enable GitHub Pages:
   - Go to repository Settings → Pages
   - Source: "Deploy from a branch"
   - Branch: `gh-pages`
   - Save

## Step 4: Update Documentation

Update the following files with your actual repository information:

1. `README.md` - Replace `YOUR_USERNAME` and `YOUR_REPO` with actual values
2. `QUICKSTART.md` - Replace placeholder URLs
3. `Chart.yaml` - Update maintainer information

## Step 5: Test the Installation

Test that users can install your chart:

```bash
# Method 1: Direct installation
helm install test-docmost https://github.com/YOUR_USERNAME/YOUR_REPO/releases/download/v0.1.0/docmost-0.1.0.tgz

# Method 2: Clone and install
git clone https://github.com/YOUR_USERNAME/YOUR_REPO.git
cd YOUR_REPO
helm install test-docmost ./docmost

# Method 3: Add as repo (if GitHub Pages is set up)
helm repo add docmost https://YOUR_USERNAME.github.io/YOUR_REPO
helm repo update
helm install test-docmost docmost/docmost
```

## Step 6: Update Chart Version

When making changes:

1. Update version in `Chart.yaml`
2. Commit changes
3. Create new tag:
   ```bash
   git tag v0.1.1
   git push origin v0.1.1
   ```

## Repository Structure

Your repository should look like this:

```
YOUR_REPO/
├── .github/
│   └── workflows/
│       ├── ci.yml
│       └── release.yml
├── docmost/
│   ├── Chart.yaml
│   ├── values.yaml
│   ├── templates/
│   └── ...
├── scripts/
│   └── setup-gh-pages.sh
├── README.md
├── QUICKSTART.md
└── GITHUB_SETUP.md
```

## Troubleshooting

### GitHub Actions Not Working

- Check that workflows are enabled in repository settings
- Ensure `GITHUB_TOKEN` secret is available
- Check workflow logs for errors

### GitHub Pages Not Working

- Verify gh-pages branch exists
- Check that GitHub Pages is enabled in settings
- Ensure `index.yaml` file is present in gh-pages branch

### Chart Installation Fails

- Verify the chart package is uploaded to releases
- Check that the download URL is correct
- Test with `helm lint` and `helm template` locally 