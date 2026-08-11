# slopshop-infra

Infrastructure for [SlopShop](https://github.com/fireship-dev/slopshop): Terraform, Docker and CI.

SlopShop routes prompts through whichever AI model is currently cheapest. This repo owns everything
needed to run it on AWS: a VPC, an ECS Fargate service behind an ALB, a Postgres database on RDS,
and an S3 bucket for static assets.

Status: work in progress. Nothing here is deployed yet.
