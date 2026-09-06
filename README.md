# slopshop-infra

Infrastructure for [SlopShop](https://github.com/fireship-dev/slopshop): Terraform, Docker and CI.

SlopShop routes prompts through whichever AI model is currently cheapest. This repo owns everything
needed to run it on AWS: a VPC, an ECS Fargate service behind an ALB, a Postgres database on RDS,
and an S3 bucket for static assets.

## Layout

```
.
├── Dockerfile              # multi-stage Node build for the app image
├── docker-compose.yml      # local dev: app + Postgres
├── terraform/
│   ├── main.tf             # provider, backend, shared locals
│   ├── vpc.tf              # VPC, subnets, NAT, routing
│   ├── security_groups.tf  # ALB / ECS / RDS security groups
│   ├── ecs.tf              # cluster, task definition, service, ALB
│   ├── rds.tf              # Postgres instance + DATABASE_URL parameter
│   ├── s3.tf               # static assets bucket
│   ├── iam.tf              # task execution and task roles
│   ├── variables.tf
│   ├── outputs.tf
│   └── environments/       # per-environment tfvars (non-secret values only)
└── .github/workflows/      # fmt + validate on every PR
```

## Environments

| Environment | tfvars                               | Notes                               |
| ----------- | ------------------------------------ | ----------------------------------- |
| dev         | `terraform/environments/dev.tfvars`  | single NAT, t4g.micro db, 1 task    |
| prod        | `terraform/environments/prod.tfvars` | multi-AZ db, deletion protection on |

Each environment lives in its own Terraform workspace so state is kept separate:

```sh
cd terraform
terraform workspace select dev || terraform workspace new dev
```

## Deploying

Secrets are never committed. The database password is a `sensitive` variable with no default, so
export it before planning:

```sh
export TF_VAR_db_password="$(aws secretsmanager get-secret-value --secret-id slopshop/dev/db --query SecretString --output text)"

cd terraform
terraform init
terraform plan  -var-file=environments/dev.tfvars -out=dev.tfplan
terraform apply dev.tfplan
```

The app image is built from the [slopshop](https://github.com/fireship-dev/slopshop) repo using the
`Dockerfile` in this repo and pushed to `ghcr.io/fireship-dev/slopshop`. Point `container_image` at
the tag you want to run.

## Local development

```sh
docker compose up --build
```

This brings up the app on <http://localhost:3000> and a Postgres 16 instance on `localhost:5432`
(user, password and database are all `slopshop`; local use only).

## CI

Every pull request that touches `terraform/` runs `terraform fmt -check` and `terraform validate`.
Run `terraform fmt -recursive` before pushing, otherwise the check will fail.

## Conventions

- Resource names are prefixed with `${project}-${environment}`.
- Anything reachable from the internet goes through the ALB. ECS tasks and RDS live in private subnets.
- Prefer referencing security groups over CIDR ranges in ingress rules.
- Tag everything. `default_tags` on the provider covers `Project`, `Environment` and `ManagedBy`.
