# see https://cryptvault.cloud/guides/create_your_cryptvault/create_vault/

resource "cryptvault_cloud_vault" "my_vault" {
  name  = "example vault"
  token = var.token_id
}

output "vault_id" {
  value = cryptvault_cloud_vault.my_vault.id
}

output "vault_name" {
  value = cryptvault_cloud_vault.my_vault.name
}

