locals {
  config = yamldecode(file("provisioning.yaml"))
}
