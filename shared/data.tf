data "terraform_remote_state" "self-vpc" {
  backend = "local"
  config = {
    path = "../vpc/terraform.tfstate"
  }
}
