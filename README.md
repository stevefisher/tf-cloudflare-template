# Introduction

This project is intended to do provide a quick start template for managing an existing domain zone and it's records in Cloudflare with Terraform.

No Terraform resources have been created as part of the project, but we will be using cf-terraforming to help generate and import them.

## Pre-requisites

Before gettting started download the appropriate cf-terraforming release for the platform you are using from https://github.com/cloudflare/cf-terraforming/releases

We now need to create a `secrets.tfvars` file in the root of the project with the following contents:

```bash
cloudflare_api_token = <This is a token you will need to generate with Zone.DNS edit permnissions>
cloudflare_domain = <The domain you are going to manage>
```

We can then run:

```bash
terraform init
terraform apply -var-file="secrets.tfvars"
```

This will give us our zoneid as a terraform output, so make a note of it as we are going to need it for running cf-terraforming.

## Terraform resource creation

First of all we will create the resource records by running the following commands. Make sure you replace the email, token and z values with your information.

```bash
# Generate the terraform resources file containing our zone records
cf-terraforming generate --email $cloudflare_email --token $cloudflare_api_token  -z $cloudflare_zone_id --resource-type cloudflare_zone > resources_zone.tf

# Generate the terraform resources file containing our domains records
cf-terraforming generate --email $cloudflare_email --token $cloudflare_api_token  -z $cloudflare_zone_id --resource-type cloudflare_record > resources_records.tf
```

> I've not found a way to prevent cf-terraforming from creating resources for all zones in your Cloudflare account so make sure you edit this to include just the zones you are looking to manage with Terraform.

## Terraform resource import into state

At this point we have the Cloudflare resource files and we need to import the resources into state. Currently cf-terraforming will only generate the commands you need, but you will need to run them manually as it doesn't automate the import.

Run the following commands and then run the commands you are given. Make sure you replace the email, token and z values with your information again.

```bash
cf-terraforming import --resource-type "cloudflare_zone" --email $cloudflare_email --token $cloudflare_api_token  -z $cloudflare_zone_id
cf-terraforming import --resource-type "cloudflare_record" --email $cloudflare_email --token $cloudflare_api_token  -z $cloudflare_zone_id
```

## Conclusion

At this point you'll have a ready to use the Terraform project and if you run `terraform plan` you'll see that no changes are required as everything matches the state. You can now make modifications and apply changes to manage your Clourflare domain with Terraform.
