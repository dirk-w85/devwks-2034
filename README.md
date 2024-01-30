# DEVWKS-2034
Repo for DEVWKS-2034

## Section One: Intro to ThousandEyes
### Login URL
https://app.thousandeyes.com/login

### API Documentation
https://developer.thousandeyes.com/v7

### Usernames

user11@pseudoco.net

user12@pseudoco.net

user13@pseudoco.net

user14@pseudoco.net

user15@pseudoco.net

user16@pseudoco.net

user17@pseudoco.net

user18@pseudoco.net

user19@pseudoco.net

user20@pseudoco.net

user21@pseudoco.net

user22@pseudoco.net

user23@pseudoco.net

user24@pseudoco.net

user25@pseudoco.net

user26@pseudoco.net

user27@pseudoco.net

user28@pseudoco.net

user29@pseudoco.net

user30@pseudoco.net

user31@pseudoco.net

user32@pseudoco.net

### Get an API Key

Navigate to Account Settings > Users and Roles > Profile > User API Tokens

### Create a Test Manually

Navigate to Cloud & Enterprise Agents > Test Settings. Click on the Add New Test button.


## Section Two: Introduction to Terraform

### Configuring the ThousandEyes Terraform Provider

Terraform relies on plugins called "providers" to interact with remote systems. Terraform configurations must declare which providers they require, so that Terraform can install and use them. At the top of the “main.tf” file, add the following block of code - this tells Terraform to use the ThousandEyes Terraform Provider.

```
terraform {
   required_providers {
      thousandeyes = {
      source = "thousandeyes/thousandeyes"
      version = ">= 1.3.1"
      }
    } 
}
```

Next, there are two configuration options we need to define:
1. The OAuth Bearer Token you created in Section One, and
2. The ThousandEyes Account Group ID

We can use the ThousandEyes API to identify our Account Group ID. In your terminal window, run curl against the ThousandEyes API with your OAuth Bearer token.

```
curl https://api.thousandeyes.com/v7/account-groups \ -H "Authorization: Bearer Your-OAuth-Token-Here"
```

The response output should look like this; note the “aid” value.

```
{
    "accountGroups": [{
        "accountGroupName": "IMPACTFY24-WSDN26", 
        "aid": 1712921,
        "current": 1,
        "default": 1,
        "organizationName": "IMPACTFY24-WSDN26"
    }] 
}
```

Back in your “main.tf” file, add a new block beneath the block you’ve already added:
```
provider "thousandeyes" {
    token = "insert-your-OAuth-bearer-token-here"
    account_group_id = "1712921"
 }
```

### Defining a ThousandEyes test in Terraform code
Now that we’ve included and configured the ThousandEyes Terraform Provider, let’s define a new ThousandEyes test using Terraform code. Add the following block to your “main.tf” file.

```
resource "thousandeyes_http_server" "api_thousandeyes_http_test" {
    test_name = "ThousandEyes API Test - User <#>"
    interval = 60
    alerts_enabled = false
    url = "https://api.thousandeyes.com/status.json"
    agents {
        agent_id = 61
    }
}
```

Make sure to save your “main.tf” file at this point.

### Initializing Terraform
In your terminal, change your working directory to the DEVWKS-2034 directory:
```cd ~/Desktop/wsdn26/terraform```

Then, run:
```terraform init```

You should see the following output:
```
Initializing the backend...

Initializing provider plugins...
- Reusing previous version of thousandeyes/thousandeyes from the dependency lock file
- Installing thousandeyes/thousandeyes v2.0.8...
- Installed thousandeyes/thousandeyes v2.0.8 (self-signed, key ID 02BB91CE566497C7)

Partner and community providers are signed by their developers.
If you'd like to know more about provider signing, you can read about it here:
https://www.terraform.io/docs/cli/plugins/signing.html

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
```
