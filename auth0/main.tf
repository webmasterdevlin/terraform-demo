resource "auth0_email" "my_email_provider" {
  name                 = "ses"
  enabled              = true
  default_from_address = "accounts@example.com"
  credentials {
    access_key_id     = "AKIAXXXXXXXXXXXXXXXX"
    secret_access_key = "7e8c2148xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
    region            = "us-east-1"
  }
}

resource "auth0_email_template" "my_email_template" {
  template                = "welcome_email"
  body                    = "<html><body><h1>Welcome to Terraform and Auth0!</h1></body></html>"
  from                    = "welcome@example.com"
  result_url              = "https://example.com/welcome"
  subject                 = "Welcome"
  syntax                  = "liquid"
  url_lifetime_in_seconds = 3600
  enabled                 = true

  depends_on = [auth0_email.my_email_provider]
}


resource "auth0_hook" "my_hook" {
  name       = "My Pre User Registration Hook"
  script     = <<EOF
        function (user, context, callback) { 
                callback(null, { user }); 
        }
        EOF
  trigger_id = "pre-user-registration"
  enabled    = true
}
