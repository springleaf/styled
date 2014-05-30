module Styled
  class GuidesController < ApplicationController
    helper_method :available_layouts

    layout "styled/application"

    def index
    end

    def show
    end

  private
    def available_layouts
      files.map { |file| name(file) } - ["styled/application"]
    end

    def files
      @files ||= paths.map { |path| Dir[path + "/**/[^_]*.html.{haml,erb,slim}"] }.flatten
    end

    def paths
      @paths ||= Dir[*view_paths.map { |path| path.to_s + "/layouts" }]
    end

    def name(file)
      file = strip_path(file)

      dirname  = File.dirname(file)
      basename = File.basename(file).sub /\.html\.(?:haml|erb|slim)/, ''

      dirname == '.' ? basename : [dirname, basename].join('/')
    end

    def strip_path(file)
      paths.each { |path| file.sub!(path, '') }
      file.sub!(/^\//, '')
      file
    end
  end
end
