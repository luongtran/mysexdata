module PhotosHelper

  require 'net/ftp'
  require 'stringio'

  # Number of files that are by default in each folder.
  PREDEFINED_FILES = 2

  # Method that uploads a picture to a FTP server.
  def uploadPictureToFTP(id,name, image, max_pic)
    errors  = {}
    logger.info "[INFO] Establishing connection with FTP Server"
    # FTP connection
    ftp = Net::FTP.new(FTP_HOST)
    ftp.passive = true
    begin
      login = ftp.login(FTP_USERNAME, FTP_PASSWORD)
    rescue Net::FTPPermError
      logger.debug "[ERROR] User cannot be logged in"
      errors[:error] = "User cannot be logged in"
      return errors
    end
    if login
      logger.info "[INFO] Login Done"
      # Cheking routes existence
      folders = ftp.nlst
      if !folders.any?{|s| s.include? 'profile_pictures'}
        if !ftp.mkdir("#{PATH_TO_WEB_FILE}")
          logger.debug "[ERROR] Cannot create #{PATH_TO_WEB_FILE} directory"
          errors[:error] = "Cannot create #{PATH_TO_WEB_FILE} directory"
          ftp.close
          return errors
        end
      end
      # Access to /profile_pictures
      ftp.chdir(PATH_TO_WEB_FILE)
      folders = ftp.nlst
      # Creating user folder if doesn't exist.
      if !folders.any?{|s| s.include? "user_#{id}"}
        if !ftp.mkdir("#{PATH_TO_WEB_FILE}/user_#{id}")
          logger.debug "[ERROR] Cannot create #{PATH_TO_WEB_FILE}/user_#{id} directory"
          errors[:error] = "Cannot create #{PATH_TO_WEB_FILE}/user_#{id} directory"
          ftp.close
          return errors
        end
      end

      # Access to /profile_pictures/user_1
      ftp.chdir("#{PATH_TO_WEB_FILE}/user_#{id}")

      # Checking if this file exists to add or not an extension e.g. (1)
      file_name = "#{PATH_TO_WEB_FILE}/user_#{id}/#{name}"
      files = ftp.nlst
      if files.length >= max_pic+ PREDEFINED_FILES
        logger.debug "[ERROR] Picture can't be uploaded because excedeed maximum size"
        errors[:error] = "Picture can't be uploaded because excedeed maximum size"
        ftp.close
        return errors
      end

      # Getting name and extension file.
      file_without_extension = name.split('.')[0]
      file_extension = name.split('.')[1]

      # Iterating over files to check for file name.
      # If it exists, we add a (1) at the end.
      # if it exists with some (\d) pattern, get the number and add 1.
      # else we add the file with original name.
      pattern = /#{file_without_extension}\(\d\).#{file_extension}/
      files.each do |s|
          if s.match(/#{name}/) != nil
            name = "#{file_without_extension}(1).#{file_extension}"
          else
            name_str = s.match(pattern)
            if name_str!= nil
              n_str = name_str[0]
              file_count = n_str[/\((.*?)\)/m,1]
              file_count = file_count.to_i
              file_count += 1
              name = "#{file_without_extension}(#{file_count}).#{file_extension}"
            end
          end
      end
      # Send string image
      ftp.puttextcontent(image, name)
      logger.info "[INFO] Sending content to FTP Server"

      # Finish ftp connection
      if  ftp.last_response_code == OK
          logger.info "[INFO] Image sended"
        ftp.close
        return errors
      end
    end

    ftp.close
    return errors
  end

def removePictureFromFTP (id, name)
  # FTP connection
  errors = {}
  ftp = Net::FTP.new(FTP_HOST)
  ftp.passive = true
  begin
    login = ftp.login(FTP_USERNAME, FTP_PASSWORD)
  rescue Net::FTPPermError
    logger.debug "[ERROR] User cannot be logged in"
    errors[:error] = "User cannot be logged in"
    return errors
  end
  if login
    begin
      ftp.delete("#{PATH_TO_WEB_FILE}/user_#{id}/#{name}")
    rescue
      logger.debug "[ERROR] Picture cannot be deleted from FTP Server"
      errors[:error] = "Picture cannot be deleted from FTP Server"
    ensure
      if ftp.last_response_code == OK
          return errors
      end
      ftp.close
      return errors
    end
  end
end

def retrievePictureFromFTP(id, name)
  # FTP connection
  errors = {}
  ftp = Net::FTP.new(FTP_HOST)
  ftp.passive = true
  begin
    login = ftp.login(FTP_USERNAME, FTP_PASSWORD)
  rescue Net::FTPPermError
    logger.debug "[ERROR] User cannot be logged in"
    errors[:error] = "User cannot be logged in"
    return errors
  end
  if login
    begin
      ftp.gettextfile("#{PATH_TO_WEB_FILE}/user_#{id}/#{name}", nil) {|data| @picture = data}
      logger.debug "[INFO] Retrieving picture from #{PATH_TO_WEB_FILE}/user_#{id}/#{name}"
    rescue
      logger.debug "[ERROR] Picture cannot be found in FTP Server"
      errors[:error] = "Picture cannot be found in FTP Server"
    ensure
      if ftp.last_response_code == OK
          return @picture
      end
      ftp.close
      return errors
    end
  end
end


  # Override method to send a string using FTP protocol
  class Net::FTP
    def puttextcontent(content, remotefile, &block)
      f = StringIO.new(content)
      begin
        storlines("STOR " + remotefile, f, &block)
      ensure
        f.close
      end
    end
  end
end
