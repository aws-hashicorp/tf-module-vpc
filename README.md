# tf-module-vpc

Este módulo de Terraform crea y configura una VPC en AWS, incluyendo subredes privadas, subredes para bases de datos y la opción de adjuntar un Transit Gateway.

## Variables

### Globales
- **`availability_zones`**: Lista de zonas de disponibilidad para las subredes privadas. *(Opcional, por defecto: `[""]`)*

### VPC
- **`create_vpc`**: Indicador para crear una VPC. *(Opcional, por defecto: `true`)*  
- **`vpc_cidr_block`**: Rango CIDR para la VPC. *(Obligatorio)*  
- **`name`**: Nombre de la VPC. *(Opcional, por defecto: `"my-vpc"`)*

### Subred Privada
- **`create_private_subnet`**: Indicador para crear una subred privada. *(Opcional, por defecto: `true`)*  
- **`private_subnet_cidr_block`**: Rango CIDR para la subred privada. *(Opcional, por defecto: `[""]`)*

### Subred de Base de Datos
- **`create_database_subnet`**: Indicador para crear una subred de base de datos. *(Opcional, por defecto: `true`)*  
- **`database_subnet_cidr_block`**: Rango CIDR para la subred de base de datos. *(Opcional, por defecto: `[""]`)*

### Transit Gateway
- **`create_transit_gateway_attachment`**: Indicador para crear un adjunto de Transit Gateway. *(Opcional, por defecto: `true`)*  
- **`transit_gateway_id`**: ID del Transit Gateway. *(Obligatorio si `create_transit_gateway_attachment` es `true`)*

## Outputs

- **`vpc_id`**: ID de la VPC creada.  
- **`vpc_arn`**: ARN de la VPC creada.  
- **`vpc_cidr_block`**: Rango CIDR asignado a la VPC.

## Uso

```hcl
module "vpc" {
    source                          = "ruta/al/modulo"
    create_vpc                      = true
    vpc_cidr_block                  = "10.0.0.0/16"
    name                            = "mi-vpc"
    availability_zones              = ["us-east-1a", "us-east-1b"]
    create_private_subnet           = true
    private_subnet_cidr_block       = ["10.0.1.0/24", "10.0.2.0/24"]
    create_database_subnet          = true
    database_subnet_cidr_block      = ["10.0.3.0/24"]
    create_transit_gateway_attachment = true
    transit_gateway_id              = "tgw-12345678"
}
```

## Requisitos

- Terraform >= 1.0  
- Proveedor AWS >= 3.0
