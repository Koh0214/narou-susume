class ApplicationController < ActionController::Base
  def root
    render html: "rails_appへようこそ!"
  end
end
