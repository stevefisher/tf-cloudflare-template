variable "cloudflare_api_token" {
  description = "Cloudlare API token"
  type        = string
  sensitive   = true
}

variable "cloudflare_domain" {
  description = "Cloudlare domain name to manage"
  type        = string
  sensitive   = true
}