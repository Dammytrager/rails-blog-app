class TesterController < ApplicationController
  def index
    render html: helpers.tag.h1('Hello world')
  end
end