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

require 'test_helper'

class UrlTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
