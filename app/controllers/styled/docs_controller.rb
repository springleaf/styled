module Styled
  class DocsController < ApplicationController
    helper_method :theme

    layout false

    def show
      session[:theme] = params[:theme] if params[:theme]

      unless params[:page]
        redirect_to doc_path(path: params[:path], page: "index")
        return
      end

      if params[:path]
        render "styled/docs/#{params[:path]}/#{params[:page]}"
      else
        render "styled/docs/#{params[:page]}"
      end
    end

  private
    def theme
      if session[:theme] == "application"
        "application"
      elsif session[:theme].present?
        "themes/#{session[:theme]}"
      else
        "application"
      end
    end
  end
end
