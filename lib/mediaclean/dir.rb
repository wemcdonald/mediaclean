if FAKEFS
  FakeFS.activate!
end

class Mediaclean::Dir < ::Dir
  def contents
    reject {|f| f == '.' or f == '..' }
  end

  def complete_contents
    @complete ||= Dir::glob("#{path}/**/*")
  end

  def to_s(indent=0)
    str = '  ' * indent + File.basename(path) + "\n"
    contents.each do |file|
      str << '  '*(indent+1) + Mediaclean::File.new("#{path}/#{file}").path + "\n"
    end
    str
  end

  def tv_confidence
    confidence = 0
    confidence += 1 if !complete_contents.grep(/season/i).empty?
    confidence += 1 if !complete_contents.grep(/series/i).empty?
    confidence += 1 if !complete_contents.grep(/episode/i).empty?
    confidence += 1 if !complete_contents.grep(/complete/i).empty?

    confidence += 1 if complete_contents.
      grep(Mediaclean::Config.video_extensions_regex).
      select { |f| File::Stat.new(f).size > 75_000_000 }.
      count >= 3

    confidence
  end
end

if FAKEFS
  FakeFS.deactivate!
end