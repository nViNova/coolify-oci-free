# Random resource ID
resource "random_string" "resource_code" {
  length  = 3
  special = false
  upper   = false
}
