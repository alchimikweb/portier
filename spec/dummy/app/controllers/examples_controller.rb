class ExamplesController < ApplicationController
  protect_from_forgery

  def index
    render text: 'dummy'
  end

  def show
    render text: 'dummy'
  end
end
