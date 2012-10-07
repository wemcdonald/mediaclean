require 'spec_helper'
require 'fakefs/safe'

def dp(path)
  FileUtils.mkdir_p(path)
end
def fp(path, size=0)
  FileUtils.touch_p(path, size)
end
def d(path)
  Mediaclean::Dir.new(path)
end
def dc(path)
  dp(path)
  d(path)
end

describe Mediaclean::Dir do
  include FakeFS::SpecHelpers

  describe '#contents' do
    it "shoud always exlude . and .." do
      fp '/tmp/foo/baz.avi'
      fp '/tmp/foo/bar.avi'
      dc('/tmp/foo').contents.should =~ ['bar.avi', 'baz.avi']
    end
  end

  describe '#tv_confidence' do
    %w[series season episode complete].each do |key|
      it "increases if there's '#{key}' somewhere" do
        fp("/tmp/foo #{key} bar.avi")
         d('/tmp').tv_confidence.should == 1
      end

      it "ignores case for #{key}" do
        fp("/tmp/foo #{key.capitalize} bar.avi")
         d('/tmp').tv_confidence.should == 1
      end
    end

    it "is cumulative" do
      fp('/tmp/season 1 complete/episode 2.avi')
       d('/tmp').tv_confidence.should == 3
    end

    it "increases if there are >= 3 video files of > 75M" do
      exts = Mediaclean::Config.video_extensions
      fp "/tmp/Show/foo.txt", 100

      fp "/tmp/Show/foo_samp.#{exts[0]}", 10_000_000
      d('/tmp').tv_confidence.should == 0

      fp "/tmp/Show/foo_samp.#{exts[1]}", 80_000_000
      d('/tmp').tv_confidence.should == 0

      fp "/tmp/Show/foo_samp.#{exts[2]}", 80_000_000
      d('/tmp').tv_confidence.should == 0

      fp "/tmp/Show/foo_samp.#{exts[3]}", 80_000_000
      d('/tmp').tv_confidence.should == 1
    end
  end
end