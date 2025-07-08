output "wrib_dashboard" {
  value = "${oci_core_instance.wrib_main.public_ip} heres the main ip"
}

output "wrib_worker_ips" {
  value = [for instance in oci_core_instance.wrib_worker : "${instance.public_ip} worker ip"]
}
