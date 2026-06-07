resource "null_resource" "migration_wave" {
  triggers = {
    name = var.migration_wave_name
  }
}
