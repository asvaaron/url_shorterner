# == Schema Information
#
# Table name: urls
#
#  id             :bigint           not null, primary key
#  title          :string(500)
#  url            :text
#  short_url      :string(350)
#  times_accessed :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Url < ApplicationRecord
  include BaseEncoders
  # Validations for url attribute not null, unique and valid url
  validates :url, presence: true
  validates_uniqueness_of :url
  validates :url, url: { no_local: true, schemas: %w(https http)}

  after_save :encode_url

  def self.fetch_web_page_title(id)
    begin
      url_change = self.find(id)
      puts url_change.url
      title_tag = Nokogiri::HTML::Document.parse(HTTParty.get(url_change.url).body).title
      url_change.title = title_tag
      url_change.save
    rescue
        Rails.logger.error p 'Error fetching url '
    end
  end
  # Get top urls ordered by most times_accessed
  def self.get_top(top_limit)
      self.order('times_accessed DESC').limit(top_limit)
  end

  def self.get_entire_url_decoded(short_url)
      # Get entire url using the short_url stored
      short_url = BaseEncoders::Base62.new.extract_valid_base_characters(short_url)
      id = BaseEncoders::Base62.new.decode_from_base(short_url, 62)
      url_founded = self.find_by id: id
      if !url_founded.nil?
        url_founded.increment!(:times_accessed)
      end
      url_founded
  end

  private

  def encode_url
    # Encode id using a base62 encoder valid values [0-9a-zA-Z]
    # Initialize times accessed to 0
    self.update_columns(
        short_url: BaseEncoders::Base62.new.encode_to_base(self.id, 62),
        times_accessed: 0
    )
    true
  end
end
