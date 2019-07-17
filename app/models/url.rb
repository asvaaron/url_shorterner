require 'base62-rb'

class Url < ApplicationRecord
  validates :url, presence: true
  validates_uniqueness_of :url

  after_save :encode_url

  def self.fetch_web_page(url_string)
      response = HTTParty.get(url_string)
      JSON.parse(response.body)
  end
  # Get top urls ordered by most times_accessed
  def self.get_top(top_limit)
      self.order('times_accessed DESC').limit(top_limit)
  end

  def self.get_entire_url_decoded(short_url)
      url_founded = self.find_by short_url: short_url
      if !url_founded.nil?
        url_founded.increment!(:times_accessed)
      end
      url_founded
  end

  private

  def encode_url
    self.update_columns(
        short_url: Base62.encode(self.id),
        times_accessed: 0
    )
    true
  end
end
