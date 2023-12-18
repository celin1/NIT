require 'zip'

module MyApplacationSelin
  class Zipper
    class << self
      def zip(zipfile_name, ext)
        input_filenames = Dir["*.#{ext}"]
        folder = "./"

        if File.file?(zipfile_name)
          file_mode = IO::WRONLY | IO::CREAT | IO::TRUNC |= IO::BINARY | IO::SHARE_DELETE
          File.open(zipfile_name, mode: file_mode) do |f|
            File.delete(f)
          end
        end

        Zip::File.open(zipfile_name, create: true) do |zipfile|
          input_filenames.each do |filename|
            zipfile.add(filename, File.join(folder, filename))
          end
        end
      end
    end
  end
end