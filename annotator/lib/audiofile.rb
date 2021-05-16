#!/usr/bin/env ruby
class AudioFile
  using Refinements::Hashes
  using Refinements::Pathnames

  attr_accessor :fullpath, :parent, :name, :extension,
                :sox_stats, :notes, :tempo

  def initialize(fullpath)
    @fullpath = Pathname.new(fullpath)
    @parent = @fullpath.relative_path_from(IMPORT).dirname
    @name = @fullpath.name
    @extension = @fullpath.extname
    @sox_stats = {}
    @notes = []
    @tempo = 0
  end

end
