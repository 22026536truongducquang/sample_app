class StaticPagesController < ApplicationController
  def home
    return unless logged_in?

    @micropost = current_user.microposts.build
    @pagy, @feed_items = pagy current_user.feed.newest,
                              items: Settings.pagy.page_10
  end

  def help; end
end
