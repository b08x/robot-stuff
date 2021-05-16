#!/usr/bin/env ruby
class AudioFile
  using Refinements::Hashes
  using Refinements::Pathnames

  attr_accessor :fullpath, :parent, :name, :extension,
                :sox_stats, :notes, :tempo

  def initialize(fullpath)
    @fullpath = Pathname.new(fullpath)
    @parent = nil
    @name = @fullpath.name
    @extension = @fullpath.extname
    @sox_stats = {}
    @notes = []
    @tempo = 0
  end

  def parent
    @parent = @fullpath.relative_path_from(IMPORT_DIR).dirname
  end

end
