require 'google/apis/drive_v3'
require 'google/api_client/client_secrets'

module Web::Controllers::Home
  class Callback
    include Web::Action

    def call(params)
      drive = GoogleDriveApi.create_drive_service(params)

      file_metadata = {
          name: "JR-#{DateTime.now.strftime('%m/%d/%y %l:%M %p')}.txt",
      }
      file = drive.create_file(file_metadata, fields: 'id')
    end
  end
end
