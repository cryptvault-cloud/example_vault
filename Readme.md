# Example CryptVault

Here is an example of a https://cryptvault.cloud 

This example follows the [Getting Started](https://cryptvault.cloud/guides/create_your_cryptvault/overview/).

In the folder [Terraform](./terraform) you will find all examples of the Terraform implementation.

The tf files also have links to the documentation in the comments.

To run this example, you will need a cryptvault token. 
See [Create an account](https://cryptvault.cloud/guides/create_your_cryptvault/create_account/)

With the token, the commands in the terraform folder can then be executed with: 
```sh 
  terraform init
  terraform apply --var token_id=[your token].
```