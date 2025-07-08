variable "ssh_authorized_keys" {
  description = "SSH public key for instances. For example: ssh-rsa AAEAB3NaC1yc2EAAAA....3xcoeATR ssh-key-2024-09-03"
  type        = string
}

variable "compartment_id" {
  description = "The OCID of the compartment. Find it: Profile - Tenancy: youruser - Tenancy information - OCID (copy) https://cloud.oracle.com/tenancy"
  type        = string
}

variable "source_image_id" {
  description = "Source Ubuntu Minimal 24.04 image OCID. Find the right one for your region: https://docs.oracle.com/en-us/iaas/images/ubuntu-2404/index.htm e.g. ocid1.image.oc1.ap-singapore-1.aaaaaaaavpms5nv7qmalnorgvemrgumiln5en2o6xmxllosxu5cdaqmgycyq for Singapore"
  type        = string
}

variable "num_worker_instances" {
  description = "Number of wrib worker instances to deploy (max 3 for free tier)."
  type        = number
  default     = 1
}

variable "availability_domain_main" {
  description = "Availability domain for wrib-main instance. Find it Core Infrastructure → Compute → Instances → Availability domain (left menu). For example: qeno:AP-SINGAPORE-1-AD-1"
  type        = string
}

variable "availability_domain_workers" {
  description = "Availability domain for wrib-worker instances. Find it Core Infrastructure → Compute → Instances → Availability domain (left menu). For example: qeno:AP-SINGAPORE-1-AD-1"
  type        = string
}

variable "instance_shape" {
  description = "The shape of the instance. VM.Standard.A1.Flex is free tier eligible."
  type        = string
  default     = "VM.Standard.A1.Flex" # OCI Free
}

variable "memory_in_gbs" {
  description = "Memory in GBs for instance shape config. 6 GB is the maximum for free tier with 3 working nodes."
  type        = string
  default     = "12" # OCI Free
}

variable "ocpus" {
  description = "OCPUs for instance shape config. 1 OCPU is the maximum for free tier with 3 working nodes."
  type        = string
  default     = "2" # OCI Free
}
