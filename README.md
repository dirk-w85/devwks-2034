# DEVWKS-2034
Repo for DEVWKS-2034

## Section One: Intro to ThousandEyes
### Login URL
US Region: https://app.thousandeyes.com/login?teRegion=0

EU Region: https://app.thousandeyes.com/login?teRegion=1

### API Documentation
https://developer.thousandeyes.com/v7

### Terraform Provider Documentation
https://registry.terraform.io/providers/thousandeyes/thousandeyes/latest/docs

### Usernames (see number on your table)

devwks2034+user01@gmail.com

devwks2034+user02@gmail.com

devwks2034+user03@gmail.com

devwks2034+user04@gmail.com

devwks2034+user05@gmail.com

devwks2034+user06@gmail.com

devwks2034+user07@gmail.com

devwks2034+user08@gmail.com

devwks2034+user09@gmail.com

devwks2034+user10@gmail.com

devwks2034+user11@gmail.com

devwks2034+user12@gmail.com

devwks2034+user13@gmail.com

devwks2034+user14@gmail.com

devwks2034+user15@gmail.com

devwks2034+user16@gmail.com

devwks2034+user17@gmail.com

devwks2034+user18@gmail.com

devwks2034+user19@gmail.com

devwks2034+user20@gmail.com

devwks2034+user21@gmail.com

devwks2034+user22@gmail.com

devwks2034+user23@gmail.com

devwks2034+user24@gmail.com

devwks2034+user25@gmail.com

devwks2034+user26@gmail.com

devwks2034+user27@gmail.com

devwks2034+user28@gmail.com

devwks2034+user29@gmail.com

devwks2034+user30@gmail.com


### Get an API Key

Navigate to **Account Settings > Users and Roles > Profile > User API Tokens**
Scroll to the bottom and find “OAuth Bearer Token”. Click the “Create” link to open a modal dialog with your new token. 

>[!Important]
>Copy it and save it in a text file on your laptop, you will not be able to view the token later.

>[!Tip]
>If, when you click “Create”, the page refreshes without opening the modal dialog containing the token, click the
>“Create” link again. If this still does not create and show a token, please ask for help from the workshop lead.

### Create a Test Manually

Navigate to **Cloud & Enterprise Agents > Test Settings**. Click on the **Add New Test** button.

Create a Page Load test targeting URL **https://identity.pseudoco.net**: 
- Name the test “identity.pseudoco.net - User <#>”,
- Set the interval at 1 minute,
- Select up to 3 Cloud Agents for this test.
- Lastly, click “**Create New Test**”. 

We’ll let it run for a few test rounds and come back to look at the data.

## Section Two: Introduction to Terraform
### Setup the Environment 
First, open your terminal and create a directory to hold your terraform files and change to that new directory
```
mkdir /home/devnet/devwks-2034
cd /home/devnet/devwks-2034
```
In this direcotry, we create a empty file called **main.tf** where will save all our Terrform code. 

```
touch main.tf
```

### Configuring the ThousandEyes Terraform Provider
Terraform relies on plugins called "providers" to interact with remote systems. Terraform configurations must declare which providers they require, so that Terraform can install and use them. At the top of the **main.tf** file, add the following block of code - this tells Terraform to use the ThousandEyes Terraform Provider.

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
curl https://api.thousandeyes.com/v7/account-groups -H "Authorization: Bearer <Your-OAuth-Token-Here>"
```

The response output should look like this; note the “aid” value.

```
{
    "accountGroups": [{
        "accountGroupName": "DEVWKS-2034", 
        "aid": 281474976713688,
        "current": 1,
        "default": 1,
        "organizationName": "DEVWKS-2034"
    }] 
}
```

Back in your **main.tf** file, add a new block beneath the block you’ve already added:
```
provider "thousandeyes" {
    token = "<insert-your-OAuth-bearer-token-here>"
    account_group_id = "<Your-AID-Here>"
 }
```

### Defining a ThousandEyes test in Terraform code
Now that we’ve included and configured the ThousandEyes Terraform Provider, let’s define a new ThousandEyes test using Terraform code. Add the following block to your **main.tf** file.

```
resource "thousandeyes_http_server" "api_thousandeyes_http_test" {
    test_name = "ThousandEyes API Test - User <#>"
    interval = 60
    alerts_enabled = false
    url = "https://api.thousandeyes.com/status.json"
    agents {
        agent_id = 7
    }
}
```
>[!Tip]
> Agent ID #7 is the Cloud Agent in Amsterdam, Netherlands. 


Make sure to save your **main.tf** file at this point.

### Initializing Terraform

In the terminal, make sure your are working in the correct directory:
```
cd /home/devnet/devwks-2034
```

Then, run:
```
terraform init
```

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

### Planing
Before you run Terraform to apply the changes to the remote system (i.e, ThousandEyes SaaS platform), you should first use the “terraform plan” command to view what changes will be made and validate that everything looks good with the configuration:

```
terraform plan
```

The output of this command will show the actions that Terraform will take based on your Terraform configuration file:
```
Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # thousandeyes_http_server.api_thousandeyes_http_test will be created
  + resource "thousandeyes_http_server" "api_thousandeyes_http_test" {
      + alerts_enabled         = false
      + api_links              = (known after apply)
      + auth_type              = "NONE"
      + bandwidth_measurements = false
      + content_regex          = ".*"
      + created_by             = (known after apply)
      + created_date           = (known after apply)
      + enabled                = true
      + follow_redirects       = true
      + groups                 = (known after apply)
      + http_target_time       = 1000
      + http_time_limit        = 5
      + http_version           = 2
      + id                     = (known after apply)
      + interval               = 60
      + live_share             = (known after apply)
      + modified_by            = (known after apply)
      + modified_date          = (known after apply)
      + network_measurements   = true
      + path_trace_mode        = "classic"
      + probe_mode             = "AUTO"
      + protocol               = "TCP"
      + saved_event            = (known after apply)
      + ssl_version            = (known after apply)
      + ssl_version_id         = 0
      + test_id                = (known after apply)
      + test_name              = "ThousandEyes API Test - User <#>"
      + type                   = (known after apply)
      + url                    = "https://api.thousandeyes.com/status.json"
      + verify_certificate     = true

      + agents {
          + agent_id = 7
        }
    }

Plan: 1 to add, 0 to change, 0 to destroy.
```

### Apply the changes
Now that we understand what Terraform will do, let’s apply the plan:

```
terraform apply
```

Again, you will see a preview of the actions Terraform will apply, and Terraform will prompt you to confirm to perform these actions. 

>[!Important]
>Be sure to type “yes” at the prompt, and hit your enter key.

```
...
Plan: 1 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

thousandeyes_http_server.api_thousandeyes_http_test: Creating...
thousandeyes_http_server.api_thousandeyes_http_test: Creation complete after 4s [id=4787335]

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
```

You’ve now successfully deployed a ThousandEyes test via Terraform! 

Navigate to **Cloud & Enterprise Agents > Test Settings to see your new test.**

## Section Three: Importing Existing Resources
So far, we’ve used Terraform to create new resources in our cloud environments. What if we want to leverage Terraform to manage an existing resource? Recall in the first section of this exercise that we created a ThousandEyes test manually. Let’s explore the process to import that test into our Terraform code.

### Importing Resource State
First, add a new code block to “main.tf” represent the existing resource:
```
resource "thousandeyes_page_load" "identity_pseudoco_net_test" { 

}
```

Before we import the existing resource, we will need the ID of the resource we are importing. You can easily find your test ID from the ThousandEyes platform, by opening the Views for the test and looking for the `testId` URL parameter. To open the View for your “identity.pseudoco.net” test that you created manually in Section
One, navigate to ***Cloud & Enterprise Agents > Test Settings***, find your test in the list, and click on the button:


Then, run the following command to import the existing state into Terraform:
```
terraform import thousandeyes_page_load.identity_pseudoco_net_test <TEST_ID>
```

You should see the following output:
```
thousandeyes_page_load.identity_pseudoco_net_test: Importing from ID "4787373"...
thousandeyes_page_load.identity_pseudoco_net_test: Import prepared!
  Prepared thousandeyes_page_load for import
thousandeyes_page_load.identity_pseudoco_net_test: Refreshing state... [id=4787373]

Import successful!

The resources that were imported are shown above. These resources are now in
your Terraform state and will henceforth be managed by Terraform.
```

### Importing the Configuration
We have now imported the state for this resource, but next we need to import the configuration, so that we can manage this resource via Terraform going forward.
Run the `terraform show` command to display the current state, and look for the “# thousandeyes_http_server.identity_pseudoco_net_test” section in the output. It should look something like this:

```
resource "thousandeyes_page_load" "identity_pseudoco_net_test" {
    alerts_enabled         = false
    api_links              = [
        {
            href = "https://api.thousandeyes.com/v6/tests/4787373"
            rel  = "self"
        },
        {
            href = "https://api.thousandeyes.com/v6/web/http-server/4787373"
            rel  = "data"
        },
        {
            href = "https://api.thousandeyes.com/v6/web/page-load/4787373"
            rel  = "data"
        },
        {
            href = "https://api.thousandeyes.com/v6/net/metrics/4787373"
            rel  = "data"
        },
        {
            href = "https://api.thousandeyes.com/v6/net/path-vis/4787373"
            rel  = "data"
        },
        {
            href = "https://api.thousandeyes.com/v6/net/bgp-metrics/4787373"
            rel  = "data"
        },
    ]
    auth_type              = "NONE"
    bandwidth_measurements = false
    bgp_measurements       = true
    created_by             = "Dirk Woellhaf (dwoellha@thousandeyes.com)"
    created_date           = "2024-01-30 14:33:46"
    enabled                = true
    follow_redirects       = true
    http_interval          = 60
    http_target_time       = 1000
    http_time_limit        = 5
    http_version           = 2
    id                     = "4787373"
    include_headers        = true
    interval               = 60
    live_share             = false
    modified_by            = "Dirk Woellhaf (dwoellha@thousandeyes.com)"
    modified_date          = "2024-01-30 14:34:05"
    mtu_measurements       = false
    network_measurements   = true
    num_path_traces        = 3
    page_load_target_time  = 6
    page_load_time_limit   = 10
    path_trace_mode        = "classic"
    probe_mode             = "AUTO"
    protocol               = "TCP"
    saved_event            = false
    ssl_version            = "Auto"
    ssl_version_id         = 0
    test_id                = 4787373
    test_name              = "identity.pseudoco.net - User 999"
    type                   = "page-load"
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
```

Copy this block and overwrite the empty "identity_pseudoco_net_test" block in your “main.tf” file, and run `terraform plan`. You will see multiple “Value for unconfigurable attribute” errors. This is because the `terraform show` command shows the complete state, including read-only attributes. Our Terraform configuration must not contain any read-only attributes. Remove the following fields from the “identity_pseudoco_net_test” block:
- api_links
- created_by
- created_date 
- id
- live_share
- modified_by
- modified_date 
- saved_event 
- ssl_version
- test_id
- type

Next, re-run `terraform plan` and validate there are no errors. Now you are able to use Terraform to manage a test that you had initially created manually!

## Section Four: Adding Variables
Recall that when we initially set up “main.tf” with the ThousandEyes provider, we put our OAuth Bearer Token directly in the code. While this is fine for learning and experimenting, it is an anti-pattern to include secrets directly in your code files.

### Declare the Variable
Let’s replace the token configuration to use a variable that we will define outside of the code. Open **main.tf**, add a new block above the provider definition to declare the variable:

```
variable "te_oauth_token" {
   type = string
 }

variable "te_aid" {
   type = string
 }
```

Change your Provider config to use the new Variables and to look like this:
```
provider "thousandeyes" {
   token = var.te_oauth_token
   account_group_id = var.te_aid
}
```

Be sure to save the file.

### Define the Value of the Variable

Next, create a file to hold the Values for the newly defined Variables:

```
touch terraform.tfvars
```

>[!Important]
>Do NOT change the filename! Terraform explicitly looks for terraform.tfvars

Use your editor to add the follwoing lines to the Variable file:

```
te_oauth_token = "<Your-Token-Here>"
te_aid = "<Your-AID-Here>"
```

Save the file!

Now, run `terraform plan` to validate that everything is working correctly.

The follwing output is what we expect by now:
```
...

No changes. Your infrastructure matches the configuration.

...
```


## Section Five: Deploy Additional Tests for the Application Backend
We’ve now deployed a new web application, and a test that runs from ThousandEyes Cloud Agents towards that new web app. This serves as a representation for how users on the public Internet reach our app.
However, most applications today are dependent upon third party services and external APIs. Let’s presume that our web application is dependent on the following three APIs:

- api.github.com 
- api.slack.com 
- api.twilio.com

Because these API requests are made from within our AWS VPC, for the tests we set up against these targets, we want to use the Enterprise Agent we deployed earlier. This Enterprise Agent will represent our web application making third-party API calls to external dependencies across the Internet.

### Declare a Cloud Agent as a Data Source
First, add the Enterprise Agent as a new data object in **main.tf**, immediately after the “provider” block:


```
data "thousandeyes_agent" "arg_amsterdam_agent" {
    agent_name = "Amsterdam, Netherlands" 
}

data "thousandeyes_agent" "arg_lasvegas_agent" {
    agent_name = "Las Vegas, NV" 
}
```

This will allow us to reference the Enterprise Agent by name, rather than its numeric ID.

### Add New ThousandEyes HTTP Server Test Resources
Next, add three new HTTP Server test resources at the bottom of “main.tf”:

```
resource "thousandeyes_http_server" "api_github_http_test" {
    test_name = "Github API Test - User<#>"
    interval = 60
    alerts_enabled = false
    url = "https://api.github.com/"
    agents {
        agent_id = data.thousandeyes_agent.arg_amsterdam_agent.agent_id 
    }

    agents {
        agent_id = data.thousandeyes_agent.arg_lasvegas_agent.agent_id
    }
}
```

```
resource "thousandeyes_http_server" "api_slack_http_test" { 
    test_name = "Slack API Test - User<#>"
    interval = 60
    alerts_enabled = false
    url = "https://api.slack.com"
    agents {
        agent_id = data.thousandeyes_agent.arg_amsterdam_agent.agent_id 
    }

    agents {
        agent_id = data.thousandeyes_agent.arg_lasvegas_agent.agent_id
    }
}
```

```
resource "thousandeyes_http_server" "api_twilio_http_test" { 
    test_name = "Twilio API Test - User<#>"
    interval = 60
    alerts_enabled = false
    url = "https://api.twilio.com"
    agents {
        agent_id = data.thousandeyes_agent.arg_amsterdam_agent.agent_id 
    }

    agents {
        agent_id = data.thousandeyes_agent.arg_lasvegas_agent.agent_id
    }
}
```

>[!Important]
>Don´t forget to change the Test Name to match your Username. 

### Plan and Apply

Run `terraform plan` to validate there are no issues in your Terraform code files, then run `terraform apply` to apply the changes and create the three new tests in the ThousandEyes platform.

## Section Six: Modify Existing Tests -  Enable Alerting
Alerting is a crucial piece in ThousandEyes. As a best-practive we enable alerting at the end when we are sure tests are working as expected to avoid false-positives and flooding of emails or even tickets. 

Alerts can be integrated with 3rd party tools like ServiceNow, PagerDuty, Microsoft Teams and Webex. An Webex integration is already configured in this account. 
Head over to **Integrations > Webex Alert** to check it out. 
Also, a new Alert Rule was created to use this integration. This can be found unter **Alerts > Alert Rules > DEVWKS-2034 Alert Rule**
This Alert Rule is set as **default** so any test of type "HTTP Server" will inherit this Alert Rule as soon as alerting gets enabled on the test. 

To enable alerting, change the **alerts_enabled** in every test to **true** :

```
resource "thousandeyes_http_server" "api_twilio_http_test" { 
...
    alerts_enabled = true
...
}
```

Run `terraform plan` to validate, then run `terraform apply` to apply the changes.

## (optional) Section Seven: Destroy 
Once you no longer need your tests, you may want to remove them from ThousandEyes to reduce your security exposure and costs. In addition to building and modifying infrastructure, Terraform can destroy or recreate the infrastructure it manages.

The `terraform destroy` command terminates resources managed by your Terraform project. This command is the inverse of terraform apply in that it terminates all the resources specified in your Terraform state. It does not destroy resources running elsewhere that are not managed by the current Terraform project.

Before actually destroying your setup, Terraform will list all elements beeing destroyed. 

Your output should look like this, if all is ok, answer with **yes**:
```
...
Plan: 0 to add, 0 to change, 5 to destroy.

Do you really want to destroy all resources?
  Terraform will destroy all your managed infrastructure, as shown above.
  There is no undo. Only 'yes' will be accepted to confirm.

  Enter a value: yes
..
```

Head over to the ThousandEyes Platform. Under **Cloud & Enterprise Agents > Tests**, all your tests should have been removed by Terraform. 


## Conclusion
In this workshop, we used Terraform to define our Infrastructure as Code. Specifically, we used Terraform with the ThousandEyes provider to define our ThousandEyes tests in code. We created “Outside-In” tests, from Cloud Agents to our Website.
For more information, read the blog post announcing the ThousandEyes Terraform Provider. Complete documentation is available on the Terraform registry. To learn more about how we use Terraform at ThousandEyes, check out Ricard Bejarano’s “Scaling Terraform at ThousandEyes” presentation from SREcon23 Americas.
You can also learn more about public cloud performance in the ThousandEyes Cloud Performance Report. The Cloud Performance Report analyzes the performance and connectivity architectures of the top three public cloud providers: Amazon Web Services (AWS), Microsoft Azure, and Google Cloud.

Thank you for joining today’s session!
