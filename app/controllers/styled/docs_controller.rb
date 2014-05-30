module Styled
  class DocsController < ApplicationController
    layout false

    def show
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
  end
end
