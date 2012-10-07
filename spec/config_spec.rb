require 'spec_helper'
require 'mediaclean'
require 'mediaclean/config'

describe Mediaclean::Config do
  it 'generates accessors' do
    (Mediaclean::Config.public_methods - Object.public_methods).should =~ [:config,
     :tv_directory,
     :movie_directory,
     :watch_directory,
     :tv_file_format,
     :movie_file_format,
     :size_tokens,
     :codec_tokens,
     :movie_tag_tokens,
     :tv_tag_tokens,
     :common_tag_tokens,
     :scene_tokens,
     :video_extensions,
     :subtitle_extensions,
     :extras_extensions,
     :image_extensions,

     :extras_extensions_regex,
     :image_extensions_regex,
     :subtitle_extensions_regex,
     :video_extensions_regex,
    ]
  end
end