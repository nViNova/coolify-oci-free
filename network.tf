# VCN configuration
resource "oci_core_vcn" "wrib_vcn" {
  cidr_block     = "10.0.0.0/16"
  compartment_id = var.compartment_id
  display_name   = "network-wrib-${random_string.resource_code.result}"
  dns_label      = "vcn${random_string.resource_code.result}"
}

# Subnet configuration
resource "oci_core_subnet" "wrib_subnet" {
  cidr_block     = "10.0.0.0/24"
  compartment_id = var.compartment_id
  display_name   = "subnet-wrib-${random_string.resource_code.result}"
  dns_label      = "subnet${random_string.resource_code.result}"
  route_table_id = oci_core_vcn.wrib_vcn.default_route_table_id
  vcn_id         = oci_core_vcn.wrib_vcn.id

  # Attach the security list
  security_list_ids = [oci_core_security_list.wrib_security_list.id]
}

# Internet Gateway configuration
resource "oci_core_internet_gateway" "wrib_internet_gateway" {
  compartment_id = var.compartment_id
  display_name   = "Internet Gateway network-wrib"
  enabled        = true
  vcn_id         = oci_core_vcn.wrib_vcn.id
}

# Default Route Table
resource "oci_core_default_route_table" "wrib_default_route_table" {
  manage_default_resource_id = oci_core_vcn.wrib_vcn.default_route_table_id

  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_internet_gateway.wrib_internet_gateway.id
  }
}

# Security List for wrib
resource "oci_core_security_list" "wrib_security_list" {
  compartment_id = var.compartment_id
  vcn_id         = oci_core_vcn.wrib_vcn.id
  display_name   = "wrib Security List"

  # Ingress Rules for wrib and Reverse Proxy
  ingress_security_rules {
    protocol = "6" # TCP
    source   = "0.0.0.0/0"
    tcp_options {
      min = 22
      max = 22
    }
    description = "Allow SSH traffic on port 22"
  }

  # Reverse Proxy (optional)
  ingress_security_rules {
    protocol = "6" # TCP
    source   = "0.0.0.0/0"
    tcp_options {
      min = 80
      max = 80
    }
    description = "Allow HTTP traffic on port 80"
  }

  ingress_security_rules {
    protocol = "6" # TCP
    source   = "0.0.0.0/0"
    tcp_options {
      min = 443
      max = 443
    }
    description = "Allow HTTPS traffic on port 443"
  }

  # Egress Rule (optional, if needed)
  egress_security_rules {
    protocol    = "all"
    destination = "0.0.0.0/0"
    description = "Allow all egress traffic"
  }
}
