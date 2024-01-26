/*
data "template_file" "userdata" {
  template = file("${path.module}/cloud-init.yaml")

  vars = {
    ssh_public_key = file(var.vms_ssh_root_key)
  }
}
*/
