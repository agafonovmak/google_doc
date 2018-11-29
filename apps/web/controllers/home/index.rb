require 'google/apis/drive_v3'
require 'google/api_client/client_secrets'

module Web::Controllers::Home
  class Index
    include Web::Action

    def call(params)
    client_secrets = Google::APIClient::ClientSecrets.load(Hanami.root.join('client.json'))
    auth_client = client_secrets.to_authorization
    auth_client.update!(
      :scope => 'https://www.googleapis.com/auth/drive',
      :redirect_uri => 'https://fathomless-taiga-36544.herokuapp.com/',
      :additional_parameters => {
        "access_type" => "offline",         # offline access
        "include_granted_scopes" => "true"  # incremental auth
      }
    )
    auth_uri = auth_client.authorization_uri.to_s
    redirect_to auth_uri
    end
  end
end
