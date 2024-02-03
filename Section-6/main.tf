terraform {
   required_providers {
      thousandeyes = {
      source = "thousandeyes/thousandeyes"
      version = ">= 1.3.1"
      }
    } 
}

variable "te_oauth_token" {
   type = string
 }

provider "thousandeyes" {
    token = var.te_oauth_token      
    account_group_id = "281474976713688"
}


resource "thousandeyes_alert_rule" "alert_rule" {
  rule_name  = "Alert Rule set from Terraform provider - User <#>"
  alert_type = "HTTP Server"

  expression = "((errorType == \"None\"))" # Error Type is ANY

  rounds_violating_required = 1
  rounds_violating_out_of   = 1

  minimum_sources = 1

  notifications {
    webhook {
        integration_id = "wb-281474976710838"
        integration_type = "WEBHOOK"
    }
  }

}

