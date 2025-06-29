# Docmost Helm Chart

This Helm chart deploys Docmost application with PostgreSQL database and Redis cache.

## Prerequisites

- Kubernetes cluster
- Helm 3.x
- cert-manager (for TLS certificates)
- Traefik (for ingress routing)

## Installation

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
    APP_URL: "https://docmost.mydomain.com"
    APP_SECRET: "my-secret-key"

ingress:
  hosts:
    - host: docmost.mydomain.com
      paths:
        - path: /
          pathType: Prefix

certificate:
  dnsNames:
    - docmost.mydomain.com
```

Then install with custom values:

```bash
helm install docmost ./docmost -f custom-values.yaml
```

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
| `ingress.hosts[0].host` | Hostname | `docmost.ricearaul.com` |
| `certificate.dnsNames[0]` | DNS name for certificate | `docmost.ricearaul.com` |

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