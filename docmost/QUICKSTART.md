# Quick Start Guide

## Using the Helm Chart from GitHub

### Prerequisites
- Kubernetes cluster
- Helm 3.x
- kubectl configured

### Method 1: Direct Installation (Recommended)

```bash
# Install directly from GitHub release
helm install docmost https://github.com/YOUR_USERNAME/YOUR_REPO/releases/download/v0.1.0/docmost-0.1.0.tgz
```

### Method 2: Clone and Install

```bash
# Clone the repository
git clone https://github.com/YOUR_USERNAME/YOUR_REPO.git
cd YOUR_REPO

# Install with default values
helm install docmost ./docmost

# Or install with custom values
helm install docmost ./docmost -f custom-values.yaml
```

### Method 3: Add as Helm Repository

```bash
# Add the repository
helm repo add docmost https://YOUR_USERNAME.github.io/YOUR_REPO

# Update repositories
helm repo update

# Install the chart
helm install docmost docmost/docmost
```

## Custom Values Example

Create `custom-values.yaml`:

```yaml
namespace:
  name: my-docmost

database:
  credentials:
    password: "my-secure-password"
  persistence:
    size: 5Gi

docmost:
  env:
    APP_URL: "http://docmost.mydomain.com"
    APP_SECRET: "my-secret-key"

ingress:
  mandatoryHost: "docmost.mydomain.com"
  additionalHosts:
    - "docs.mydomain.com"
    - "wiki.mydomain.com"
```

## Multiple Hosts Configuration

The chart supports multiple hosts using a single IngressRoute with OR conditions:

```yaml
ingress:
  mandatoryHost: "docmost.mydomain.com"  # Required
  additionalHosts:                       # Optional
    - "docs.mydomain.com"
    - "wiki.mydomain.com"
    - "documentation.mydomain.com"
```

This creates a single rule: `Host('docmost.mydomain.com') || Host('docs.mydomain.com') || Host('wiki.mydomain.com')`

## Verify Installation

```bash
# Check pods
kubectl get pods -n docmost-namespace

# Check services
kubectl get svc -n docmost-namespace

# Check ingress
kubectl get ingressroute -n docmost-namespace
```

## Access the Application

Once deployed, you can access Docmost at any of the configured hosts:
- `http://docmost.mydomain.com`
- `http://docs.mydomain.com`
- `http://wiki.mydomain.com`

## Uninstall

```bash
helm uninstall docmost
``` 