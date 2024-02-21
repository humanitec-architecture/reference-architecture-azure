# Azure reference architecture

module "base" {
  source = "../../modules/base"

  subscription_id = var.subscription_id
  location        = var.location
  vm_size         = var.vm_size
}
