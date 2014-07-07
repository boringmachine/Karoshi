class PagesController < ApplicationController
  skip_before_filter :authenticate_user!

  def about
  end
  
  def basic
  end
  
  def faq
  end

end
