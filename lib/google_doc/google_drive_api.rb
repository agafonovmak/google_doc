module GoogleDriveApi
  def self.create_auth_client
    client_secrets = Google::APIClient::ClientSecrets.load(Hanami.root.join('client.json'))
    auth_client = client_secrets.to_authorization
    auth_client.update!(
      :scope => 'https://www.googleapis.com/auth/drive',
      :redirect_uri => "http://localhost:2300/callback",
      :additional_parameters => {
        "access_type" => "offline",         # offline access
        "include_granted_scopes" => "true"  # incremental auth
      }
    )
    return auth_client
  end

  def self.create_drive_service(params)
    auth_client = GoogleDriveApi.create_auth_client

    auth_client.code = params[:code]
    auth_client.fetch_access_token!

    drive = Google::Apis::DriveV3::DriveService.new
    drive.authorization = auth_client

    drive
  end
end
