#!/usr/bin/env ruby

require "pathname"
require "refinements"
require "refinements/hashes"
require "refinements/pathnames"
require "shellwords"
require "fileutils"
require "tty-command"

IMPORT=File.join("/srv/share/import/media/to_sort/test/")
TMPFS=File.join("/var/tmp/processing/")
HOME=ENV['HOME']
#COLLECTION=File.join(HOME, 'Music', 'Collection')

module Globbing
  module_function

  using Refinements::Hashes
  using Refinements::Pathnames

  # => returns a pathname object for each folder in the
  # given source
  def for_folders(src_folder)
    return Pathname(src_folder).directories "**/*"
  end

    # => returns files within a given folder
  def for_files(src_folder)
    return Pathname(src_folder).files "**/*.{mp3,wma,m4a}"
  end

  def for_ogg(src_folder)
    return Pathname(src_folder).files "**/*.{ogg}"
  end

  def for_flac(src_folder)
    return Pathname(src_folder).files "**/*.{flac}"
  end

  def for_wav(src_folder)
    return Pathname(src_folder).files "**/*.{wav}"
  end

end
#http://www.andypatterns.com/index.php/blog/cloning-directories-in-ruby-using-hard-links/
module FileStuff
  module_function

  using Refinements::Pathnames

  #
  def shellescape(string)
    return Shellwords.escape(string)
  end
  # => returns the file name without an extension.
  def name(soundfile)
    return Pathname(soundfile).name
  end
  # => returns only the file extension.
  def ext(soundfile)
    return Pathname(soundfile).extname
  end

  def copy_folder_to_tmp(folder)
    source = folder.relative_path_from(IMPORT)
    tmpfs_destination = Pathname.new(TMPFS + source.to_s).cleanpath


    puts "folder = #{folder}"
    puts "gonna copy #{folder}"
    puts "\n"
    puts "source = #{source}"
    puts "tmpfs_destiation = #{tmpfs_destination}"

    FileUtils.cp_r folder, TMPFS

    return tmpfs_destination
  end

  def dir2ogg(tmp_folder)
    `dir2ogg -v -r -P -m -W --delete-input -q 10 "#{tmp_folder}"`
  end

  def move_to_collection(tmpfs_destination)
      destination = tmpfs_destination.relative_path_from(TMPFS)
      destination = Pathname.new(File.join(COLLECTION, destination)).cleanpath

      puts "moving #{tmpfs_destination.dirname} to #{destination.dirname}"

      FileUtils.mv tmpfs_destination.dirname, destination.dirname

  end

  def ffmpeg_normalize(file)
    #https://gist.github.com/whizkydee/804d7e290f46c73f55a84db8a8936d74
    #https://github.com/slhck/ffmpeg-normalize/wiki/examples
    sample_rate = `soxi -r "#{file}"`.strip.to_i

    `ffmpeg-normalize -pr -nt ebu --dual-mono "#{file}" -c:a libvorbis -ar "#{sample_rate}" -o "#{file}" -f`
  end

  def beet_import(folder="#{TMPFS}")
    cmd = TTY::Command.new(pty: true, printer: :pretty)
    cmd.run("beet import '#{TMPFS}'", :err => :out)
  end

  def sox_stats(file)
    cmd = TTY::Command.new
    return cmd.run("sox '#{file}' -n stats", :err => :out)
  end

end

# this will return a pathname object for every wav/flac sample
# found in the SAMPLES directory(recursively)
sounds = Globbing.for_files(IMPORT)

# take the full path of a file and split it
# this will create two pathname objects;
# one being the absolute path where the file
# acutally is and the other being the filename
# itself
#sounds.map! {|fullpath| fullpath.split}
folders = sounds.map {|fullpath| fullpath.dirname}
folders = folders.uniq

folders = sounds.collect {|fullpath| fullpath.dirname if fullpath.extname != ".opus"}
p folders
exit

folders.each do |folder|
  staging_directory = FileStuff.copy_folder_to_tmp(folder)
  FileStuff.dir2ogg(staging_directory.cleanpath)
  exit
  FileStuff.beet_import
  sleep 5
end



#{----------------------------------------------------------}
#this works. each folder that contains m4a/wma is converted to ogg.
# then each file is normalized.
#then then folder is copied to the collection folder
# gonna adjust this to utilize beets
# folders.each do |folder|
#   puts "#{folder}"
#   tmpfs_destination = FileStuff.copy_folder_to_tmp(folder)
#   FileStuff.dir2ogg(tmpfs_destination)
#   files = Globbing.for_ogg(tmpfs_destination)
#   files.each do |file|
#    FileStuff.ffmpeg_normalize(file)
#   end
#   #
#   FileStuff.move_to_collection(tmpfs_destination)
#
# end
#{----------------------------------------------------------}
