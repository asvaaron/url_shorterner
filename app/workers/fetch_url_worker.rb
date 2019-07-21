class FetchUrlWorker
  include Sidekiq::Worker
  sidekiq_options retry: 2, queue: 'default'
  def perform(url_id, *args)
    puts "Changed url id:#{url_id}"
    Url.fetch_web_page_title(url_id)
  end
end
