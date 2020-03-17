module AmazonS3
  class Thumbnail

    def self.get(source, target, size, update_thumb = false)
      target_folder = Configuration.get.thumbnails_folder

      Rails.logger.debug("Requested thumbnail source: #{source} target: #{target}. Update: #{update_thumb}")

      if update_thumb
        self.generate(source, target, size, target_folder)
      end

      AmazonS3::Connection.object_url(target, target_folder)
    end

    def self.generate(source, target, size, target_folder)
      if !Object.const_defined?(:MiniMagick)
        Rails.logger.warn("Could not generate thumbnail because ImageMagick is unavailable")
        return
      end
      require 'open-uri'

      Rails.logger.debug("Generating thumbnail #{source} target #{target}")

      #img = Magick::ImageList.new
      url = AmazonS3::Connection.object_url(source)
      #open(url, 'rb') { |f| img = img.from_blob(f.read) }
      img = MiniMagick::Image.open(url)
      img = img.strip
      img = img.resize(size)

      AmazonS3::Connection.put(target, File.basename(target), img.to_blob, img.mime_type, target_folder)
    end
  end
end
