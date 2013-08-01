class FeedEntry < ActiveRecord::Base
  attr_accessible :content, :data_url, :feed_id, :published, :summary, :title
  belongs_to :feed

end
