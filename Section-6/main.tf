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

variable "te_aid" {
   type = string
 }

provider "thousandeyes" {
   token = var.te_oauth_token
   account_group_id = var.te_aid
}

data "thousandeyes_agent" "arg_amsterdam_agent" {
    agent_name = "Amsterdam, Netherlands" 
}

data "thousandeyes_agent" "arg_lasvegas_agent" {
    agent_name = "Las Vegas, NV" 
}

resource "thousandeyes_http_server" "api_thousandeyes_http_test" { 
    test_name = "ThousandEyes API Test - User <#>"
    interval = 60
    alerts_enabled = true
    url = "https://api.thousandeyes.com/status.json"
    agents {
      agent_id = 7
    }
}

resource "thousandeyes_page_load" "identity_pseudoco_net_test" {
    alerts_enabled         = false
    auth_type              = "NONE"
    bandwidth_measurements = false
    bgp_measurements       = true
    enabled                = true
    follow_redirects       = true
    http_interval          = 60
    http_target_time       = 1000
    http_time_limit        = 5
    http_version           = 2
    include_headers        = true
    interval               = 60
    mtu_measurements       = false
    network_measurements   = true
    num_path_traces        = 3
    page_load_target_time  = 6
    page_load_time_limit   = 10
    path_trace_mode        = "classic"
    probe_mode             = "AUTO"
    protocol               = "TCP"
    ssl_version_id         = 0
    test_name              = "identity.pseudoco.net - User <#>"
    url                    = "https://identity.pseudoco.net:"
    use_ntlm               = false
    use_public_bgp         = true
    verify_certificate     = true

    agents {
        agent_id = 14410
    }
    agents {
        agent_id = 61
    }
    agents {
        agent_id = 7
    }

    alert_rules {
        rule_id = 6715562
    }
    alert_rules {
        rule_id = 6715563
    }
}

resource "thousandeyes_http_server" "api_github_http_test" {
    test_name = "Github API Test - User <#>"
    interval = 60
    alerts_enabled = true
    url = "https://api.github.com/"
    agents {
        agent_id = data.thousandeyes_agent.arg_amsterdam_agent.agent_id 
    }

    agents {
        agent_id = data.thousandeyes_agent.arg_lasvegas_agent.agent_id
    }
}

resource "thousandeyes_http_server" "api_slack_http_test" { 
    test_name = "Slack API Test - User <#>"
    interval = 60
    alerts_enabled = true
    url = "https://api.slack.com"
    agents {
        agent_id = data.thousandeyes_agent.arg_amsterdam_agent.agent_id 
    }

    agents {
        agent_id = data.thousandeyes_agent.arg_lasvegas_agent.agent_id
    }
}

resource "thousandeyes_http_server" "api_twilio_http_test" { 
    test_name = "Twilio API Test - User <#>"
    interval = 60
    alerts_enabled = true
    url = "https://api.twilio.com"
    agents {
        agent_id = data.thousandeyes_agent.arg_amsterdam_agent.agent_id 
    }

    agents {
        agent_id = data.thousandeyes_agent.arg_lasvegas_agent.agent_id
    }
}