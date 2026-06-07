resource "null_resource" "cutover_batch" {
  triggers = {
    name = var.cutover_batch_name
  }
}
