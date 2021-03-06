require 'spec_helper'

# Specs in this file have access to a helper object that includes
# the PhotosHelper. For example:

describe PhotosHelper do
  describe "FTP file" do
    it "stores in ftp server an image" do
      file_content = "data:image/gif;base64,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"
      helper.uploadPictureToFTP  4,'prueba.jpeg', file_content
    end

    it "removes in ftp server an image" do
      helper.removePictureFromFTP  4, 'prueba(1).jpeg'
    end
  end
end
