variable "services" {
  type = list(string)
}
variable "PROJECT_ID" {
  type = string
}

variable "API_CREDS" {
  type = object({
    API_HOST = string
    API_KEY  = string
  })
}
variable "GITHUB_REPO" {
  type=string
}
