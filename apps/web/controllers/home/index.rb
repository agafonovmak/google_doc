require 'google/apis/drive_v3'
require 'google/api_client/client_secrets'

module Web::Controllers::Home
  class Index
    include Web::Action
    include GoogleDrive

    expose :auth_uri

    def call(params)
      @auth_uri = GoogleDriveApi.create_auth_client.authorization_uri.to_s
    end
  end
end
