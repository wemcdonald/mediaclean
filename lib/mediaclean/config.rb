class Mediaclean::Config
  @@defaults = {
    tv_directory:       nil,
    movie_directory:    nil,
    watch_directory:    nil,

    tv_file_format:     '$series$/Season $season0$/$series$ - S$season0$E$episode0 - $title',
    movie_file_format:  '$title$ ($year$)/$title$ ($year$)',

    size_tokens:          %w[sd hd ws 480 480p 720 720p 1080 1080p],
    codec_tokens:         %w[xvid divx x264 h264 h.264 ac3 5.1],
    movie_tag_tokens:     %w[cam dvrip bdrip dsrip ts tc scr screener dvdscr],
    tv_tag_tokens:        %w[tvrip preair hdtv pdtv 0tv],
    common_tag_tokens:    %w[dvdrip ],
    scene_tokens:         %w[fov 2hd xor notv caph sitv lol dsr asd],

    video_extensions:     %w[avi mpg mp4 m4v mpeg mkv rmvb],
    subtitle_extensions:  %w[srt],
    extras_extensions:    %w[txt nfo sfv],
    image_extensions:     %w[jpg jpeg tbn],
  }

  def self.config; @@config; end

  user_config = YAML.load(::File.open("#{BASE_DIR}/config.yml"))
  @@config = @@defaults.merge(user_config.symbolize_keys!)
  @@defaults.keys.each do |meth|
    (class << self; self; end).class_eval do
      define_method meth do |*args|
        @@config[meth]
      end
    end
  end

  @@defaults.keys.grep(/_extensions/).each do |meth|
    (class << self; self; end).class_eval do
      define_method "#{meth}_regex" do |*args|
        regex = @@config[meth].map {|ext| "[.]#{ext}"}.join('|')
        Regexp.new("(#{regex})$")
      end
    end
  end
end