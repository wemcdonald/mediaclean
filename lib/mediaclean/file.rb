if FAKEFS
  FakeFS.activate!
end

class Mediaclean::File < ::File

  def type
    video? ? 'video' :
      subtitle? ? 'subtitle' :
      extra? ? 'extra' :
      image? ? 'image' : 'unknown'
  end

  def video?
    Mediaclean::Config.video_extensions.include? self.class.extname(self.path)[1..-1]
  end

  def subtitle?
    Mediaclean::Config.subtitle_extensions.include? self.class.extname(self.path)[1..-1]
  end

  def extra?
    Mediaclean::Config.extras_extensions.include? self.class.extname(self.path)[1..-1]
  end

  def image?
    Mediaclean::Config.image_extensions.include? self.class.extname(self.path)[1..-1]
  end


end

if FAKEFS
  FakeFS.deactivate!
end
