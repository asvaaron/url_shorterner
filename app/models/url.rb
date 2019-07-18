require 'base62-rb'

class Url < ApplicationRecord
  # Validations for url attribute not null, unique and valid url
  validates :url, presence: true
  validates_uniqueness_of :url
  validates :url, url: { no_local: true, schemas: %w(https http)}

  after_save :encode_url

  def self.fetch_web_page_title(url_string)
      return Nokogiri::HTML::Document.parse(HTTParty.get(url_string).body).title
  end
  # Get top urls ordered by most times_accessed
  def self.get_top(top_limit)
      self.order('times_accessed DESC').limit(top_limit)
  end

  def self.get_entire_url_decoded(short_url)
      # Get entire url using the short_url stored
      url_founded = self.find_by short_url: short_url
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
        short_url: Base62.encode(self.id),
        times_accessed: 0
    )
    true
  end
end
