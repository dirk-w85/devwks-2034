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
        "accountGroupName": "IMPACTFY24-WSDN26", "aid": 1712921,
        "current": 1,
        "default": 1,
        "organizationName": "IMPACTFY24-WSDN26"
    }] 
}
```