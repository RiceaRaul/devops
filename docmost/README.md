# Docmost Helm Chart

This Helm chart deploys Docmost application with PostgreSQL database and Redis cache.

## Prerequisites

- Kubernetes cluster
- Helm 3.x
- Traefik (for ingress routing)

## Installation

### From GitHub Repository

#### Method 1: Direct Installation from GitHub

```bash
# Install directly from GitHub repository
helm install docmost https://github.com/YOUR_USERNAME/YOUR_REPO/releases/download/v0.1.0/docmost-0.1.0.tgz
```

#### Method 2: Clone and Install

```bash
# Clone the repository
git clone https://github.com/YOUR_USERNAME/YOUR_REPO.git
cd YOUR_REPO

# Install the chart
helm install docmost ./docmost
```

#### Method 3: Add as Helm Repository

```bash
# Add the GitHub repository as a Helm repo
helm repo add docmost https://YOUR_USERNAME.github.io/YOUR_REPO

# Update the repository
helm repo update

# Install the chart
helm install docmost docmost/docmost
```

### Basic Installation

```bash
helm install docmost ./docmost
```

### Custom Values Installation

Create a custom values file:

```yaml
# custom-values.yaml
namespace:
  name: my-docmost-namespace

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
  paths:
    - path: /
      pathType: Prefix
```

Then install with custom values:

```bash
helm install docmost ./docmost -f custom-values.yaml
```

## GitHub Repository Setup

### 1. Push to GitHub

```bash
git init
git add .
git commit -m "Initial commit: Docmost Helm chart"
git branch -M main
git remote add origin https://github.com/YOUR_USERNAME/YOUR_REPO.git
git push -u origin main
```

### 2. Create a Release

1. Go to your GitHub repository
2. Click on "Releases" in the right sidebar
3. Click "Create a new release"
4. Tag version: `v0.1.0`
5. Release title: `v0.1.0`
6. Upload the packaged chart:
   ```bash
   helm package docmost/
   # Upload the generated docmost-0.1.0.tgz file
   ```

### 3. Enable GitHub Pages (Optional)

To use Method 3 above, enable GitHub Pages:

1. Go to repository Settings → Pages
2. Source: "Deploy from a branch"
3. Branch: `gh-pages`
4. Create the `gh-pages` branch and push the `index.yaml` file

## Configuration

### Database Configuration

| Parameter | Description | Default |
|-----------|-------------|---------|
| `database.enabled` | Enable PostgreSQL database | `true` |
| `database.image.repository` | Database image repository | `postgres` |
| `database.image.tag` | Database image tag | `16-alpine` |
| `database.credentials.database` | Database name | `docmost` |
| `database.credentials.username` | Database username | `docmost` |
| `database.credentials.password` | Database password | `STRONG_DB_PASSWORD` |
| `database.persistence.size` | Database storage size | `1Gi` |

### Redis Configuration

| Parameter | Description | Default |
|-----------|-------------|---------|
| `redis.enabled` | Enable Redis cache | `true` |
| `redis.image.repository` | Redis image repository | `redis` |
| `redis.image.tag` | Redis image tag | `7.2-alpine` |
| `redis.persistence.size` | Redis storage size | `512Mi` |

### Docmost Application Configuration

| Parameter | Description | Default |
|-----------|-------------|---------|
| `docmost.image.repository` | Docmost image repository | `docmost/docmost` |
| `docmost.image.tag` | Docmost image tag | `latest` |
| `docmost.replicaCount` | Number of replicas | `1` |
| `docmost.env.APP_URL` | Application URL | `http://localhost:3000` |
| `docmost.env.APP_SECRET` | Application secret | `STRONG_SECRET_VALUE` |
| `docmost.persistence.size` | Application storage size | `1Gi` |

### Ingress Configuration

| Parameter | Description | Default |
|-----------|-------------|---------|
| `ingress.enabled` | Enable ingress | `true` |
| `ingress.mandatoryHost` | Required hostname | `docmost.ricearaul.com` |
| `ingress.additionalHosts` | Optional additional hostnames | `[]` |
| `ingressRoute.entryPoints[0]` | Traefik entrypoint | `web` |

### Multiple Hosts Example

The ingress supports multiple hosts using a single IngressRoute with OR conditions:

```yaml
ingress:
  mandatoryHost: "docmost.mydomain.com"
  additionalHosts:
    - "docs.mydomain.com"
    - "wiki.mydomain.com"
```

This creates a single rule: `Host('docmost.mydomain.com') || Host('docs.mydomain.com') || Host('wiki.mydomain.com')`

## Environment Variables

The following environment variables are automatically generated:

- `DATABASE_URL`: Auto-generated from database configuration
- `REDIS_URL`: Auto-generated from Redis configuration

Additional environment variables can be added under `docmost.env`.

## Upgrading

```bash
helm upgrade docmost ./docmost
```

## Uninstalling

```bash
helm uninstall docmost
```

## Troubleshooting

### Check Pod Status

```bash
kubectl get pods -n docmost-namespace
```

### Check Logs

```bash
kubectl logs -n docmost-namespace deployment/docmost
```

### Check Services

```bash
kubectl get svc -n docmost-namespace
```

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test with `helm lint` and `helm template`
5. Submit a pull request

## License

This project is licensed under the MIT License. 