require 'test_helper'

class RestrictableTest < ActiveSupport::TestCase
  test "truth" do
    assert_kind_of Module, Restrictable
  end
end
