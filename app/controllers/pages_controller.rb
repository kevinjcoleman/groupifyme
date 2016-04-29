class PagesController < ApplicationController
  def home
  end

  def about
  	@title = "About"
  end

  def contact
  	@title = "Contact us"
  end

  def privacy_policy
    @title = "Privacy policy"
  end
end
