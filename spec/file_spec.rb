require 'spec_helper'
require 'fakefs/safe'
require 'mediaclean'

describe Mediaclean::File do
  describe '#video?' do
    it 'uses the config list' do
      FakeFS do
        file = Mediaclean::File.new FileUtils.touch_p('/tmp/foo/bar/bar.avi')[0]
        file.video?.should be_true
        file.type.should == 'video'
      end
    end
  end
end