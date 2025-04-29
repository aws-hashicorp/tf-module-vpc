# tf-module-vpc

Este módulo de Terraform crea y configura una VPC en AWS.

## Variables

- **`vpc_name`**: Nombre de la VPC. *(Obligatorio)*
- **`cidr_block`**: Rango CIDR para la VPC. *(Obligatorio)*
- **`enable_dns_support`**: Habilita soporte DNS. *(Opcional, por defecto: `true`)*
- **`enable_dns_hostnames`**: Habilita nombres DNS. *(Opcional, por defecto: `true`)*
- **`tags`**: Etiquetas para los recursos creados. *(Opcional)*

## Outputs

- **`vpc_id`**: ID de la VPC creada.
- **`vpc_arn`**: ARN de la VPC creada.
- **`vpc_cidr_block`**: Rango CIDR asignado a la VPC.

## Uso

```hcl
module "vpc" {
    source            = "ruta/al/modulo"
    vpc_name          = "mi-vpc"
    cidr_block        = "10.0.0.0/16"
    enable_dns_support = true
    enable_dns_hostnames = true
    tags = {
        Environment = "dev"
    }
}
```

## Requisitos

- Terraform >= 1.0
- Proveedor AWS >= 3.0

## Autor

Creado por [Tu Nombre o Equipo].