# variable "resource_group" {
#     default = "hcl-ci-rg01"
#     description = "this resource will be used for UAT environment"
# }

# variable "location" {
#   default = "centralindia"
#   description = "this resource will be used for UAT environment"
# }

variable "RG_map" {
  type = map(any)
}