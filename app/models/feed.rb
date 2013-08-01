class Feed < ActiveRecord::Base
  require 'feedzirra'
  attr_accessible :feed_url, :name
  has_many :feed_entries, dependent: :destroy
  validates :feed_url, :name, presence: true
  validates_format_of :feed_url, :with => /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/ix
  after_create :update_feed_entry
  
  
  def update_feed_entry
    begin    
      @old_entries = self.feed_entries
      @feed =  Feedzirra::Feed.fetch_and_parse(self.feed_url)
      @feed.entries.each do |entry|
        if @old_entries.detect{|x| x.data_url == entry.url}.nil?
            @new_entry = FeedEntry.new
            @new_entry.title = entry.title
            @new_entry.data_url = entry.url
            @new_entry.summary = entry.summary
            @doc = Pismo::Document.new(entry.url)
            @new_entry.content = @doc.html_body
            @new_entry.published = entry.published
            @new_entry.feed_id = self.id
            @new_entry.save(validate: false)
        end    
      end  
    rescue
        # ignore
    end
  end
  
  handle_asynchronously :update_feed_entry
end
