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
    account_group_id = "225536"
}

resource "thousandeyes_http_server" "api_thousandeyes_http_test" { 
    test_name = "ThousandEyes API Test - User <#>"
    interval = 60
    alerts_enabled = false
    url = "https://api.thousandeyes.com/status.json"
    agents {
      agent_id = 61
    }
}
