# see https://cryptvault.cloud/guides/create_your_cryptvault/create_identities/

# Create a new identity keypair
resource "cryptvault_cloud_keypair" "Search_Team" {}

# Register Keypair to cryptvault.cloud
resource "cryptvault_cloud_identity" "Search_Team" {
  name        = "Search_Team"
  vault_id    = cryptvault_cloud_vault.my_vault.id
  creator_key = cryptvault_cloud_vault.my_vault.operator_private_key
  public_key  = cryptvault_cloud_keypair.Search_Team.public_key
  rights = [
    {
      # Search_Team can create new identities, but at most with the rights to the VALUES to which it is itself entitled
      right_value_pattern = "(rwd)IDENTITY.>"
    },
    {
      # Team internal secrets
      right_value_pattern = "(rwd)VALUES.search_team.>"
    }
  ]
}


# see https://cryptvault.cloud/guides/create_your_cryptvault/create_secrets/#the-search-team-side

resource "cryptvault_cloud_value" "a_service_connection_string" {
  name        = "VALUES.search_team.a_team.a_service.connection_string"
  vault_id    = cryptvault_cloud_vault.my_vault.id
  creator_key = cryptvault_cloud_keypair.Search_Team.private_key
  passframe   = "connection_string_secret_with_password_etc"
  type        = "String"
  depends_on  = [cryptvault_cloud_identity.A_Service]
}
