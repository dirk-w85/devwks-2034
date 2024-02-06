terraform {
   required_providers {
      thousandeyes = {
      source = "thousandeyes/thousandeyes"
      version = ">= 1.3.1"
      }
    } 
}

provider "thousandeyes" {
    token = "<insert-your-OAuth-bearer-token-here>"      
    account_group_id = "<Your-AID-Here>"
}

resource "thousandeyes_http_server" "api_thousandeyes_http_test" { 
    test_name = "ThousandEyes API Test - User <#>"
    interval = 60
    alerts_enabled = false
    url = "https://api.thousandeyes.com/status.json"
    agents {
      agent_id = 7
    }
}
