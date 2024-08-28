provider "aws" {
  region = data.terraform_remote_state.part1.outputs.aws_region
}

data "terraform_remote_state" "part1" {
  backend = "local"
  config = {
    path = "../part1/terraform.tfstate"
  }
}