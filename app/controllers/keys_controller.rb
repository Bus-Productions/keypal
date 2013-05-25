class KeysController < ApplicationController
  # GET /keys
  # GET /keys.json
  def index
    @keys = Key.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @keys }
    end
  end

end
