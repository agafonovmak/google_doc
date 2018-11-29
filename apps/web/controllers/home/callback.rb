require 'google/apis/drive_v3'
require 'google/api_client/client_secrets'

module Web::Controllers::Home
  class Callback
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
      auth_client.code = params[:code]
      auth_client.fetch_access_token!

      drive = Google::Apis::DriveV3::DriveService.new
      drive.authorization = auth_client

      file_metadata = {
          name: "JR-#{DateTime.now.strftime('%m/%d/%y %l:%M %p')}.txt",
      }
      file = drive.create_file(file_metadata, fields: 'id')
    end
  end
end
