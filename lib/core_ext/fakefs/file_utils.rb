require 'fakefs/safe'

module FileUtils
  def self.touch_p(path, size)
    mkdir_p File.dirname(path)
    
    size = (size - 2 >= 0) ? size - 2 : 0
    f = File.open(path, 'w')
    f.seek(size)
    f.write('\0')
    f.close
  end
end

module FakeFS
  module FileUtils
    def self.touch_p(path, size)
      mkdir_p File.dirname(path)

      size = (size - 2 >= 0) ? size - 2 : 0
      f = File.open(path, 'w')
      f.seek(size)
      f.write('\0')
      f.close
    end
  end
end