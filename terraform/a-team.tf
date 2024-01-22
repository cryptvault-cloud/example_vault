#see  https://cryptvault.cloud/guides/create_your_cryptvault/create_identities/

# Create a new identity keypair
resource "cryptvault_cloud_keypair" "A_Team" {}

# Register Keypair to cryptvault.cloud
resource "cryptvault_cloud_identity" "A_Team" {
  name        = "A_Team"
  vault_id    = cryptvault_cloud_vault.my_vault.id
  creator_key = cryptvault_cloud_vault.my_vault.operator_private_key
  public_key  = cryptvault_cloud_keypair.A_Team.public_key
  rights = [
    {
      # A_team can create new identities, but at most with the rights to the VALUES to which it is itself entitled
      right_value_pattern = "(rwd)IDENTITY.>"
    },
    {
      # Team internal secrets
      right_value_pattern = "(rwd)VALUES.a_team.>"
    },
    {
      #  secrets from search_team for a_team
      right_value_pattern = "(rwd)VALUES.search_team.a_team.>"
    }
  ]
}


# see https://cryptvault.cloud/guides/create_your_cryptvault/create_secrets/#the-a-team-side

resource "cryptvault_cloud_value" "a_service_admin_key" {
  name        = "VALUES.a_team.a_service.admin_key"
  vault_id    = cryptvault_cloud_vault.my_vault.id
  creator_key = cryptvault_cloud_keypair.A_Team.private_key
  passframe   = "Some Secret"
  type        = "String"
  depends_on  = [cryptvault_cloud_identity.A_Team]
}

resource "cryptvault_cloud_value" "a_service_email_connection" {
  name        = "VALUES.a_team.a_service.mail"
  vault_id    = cryptvault_cloud_vault.my_vault.id
  creator_key = cryptvault_cloud_keypair.A_Team.private_key
  passframe   = "Some other Secret"
  type        = "String"
  depends_on  = [cryptvault_cloud_identity.A_Team]
}

# Create a new identity keypair
resource "cryptvault_cloud_keypair" "A_Service" {}

# Register Keypair to cryptvault.cloud
resource "cryptvault_cloud_identity" "A_Service" {
  name        = "A_Service"
  vault_id    = cryptvault_cloud_vault.my_vault.id
  creator_key = cryptvault_cloud_keypair.A_Team.private_key
  public_key  = cryptvault_cloud_keypair.A_Service.public_key
  rights = [
    {
      # Team internal secrets
      right_value_pattern = "(r)VALUES.a_team.a_service.>"
    },
    {
      # Search_team connection string
      right_value_pattern = "(r)VALUES.search_team.a_team.a_service.connection_string"
    }
  ]
  depends_on = [cryptvault_cloud_identity.A_Team]
}

output "A_Service_identity" {
  value     = cryptvault_cloud_keypair.A_Service.private_key
  sensitive = true
}
