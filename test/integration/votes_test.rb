require 'test_helper'

class VotesTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:alice)
    sign_in(@user)

    @january = events(:january)

    @alien    = movies(:alien)
    @tron     = movies(:tron)
    @lebowski = movies(:lebowski)

    visit event_path(@january)
  end

  def teardown
    Warden.test_reset!
  end

  test "Event page shows how many votes each movie has" do
    within(".movie-list") do
      assert find("tr", text: @alien.title).has_selector?("td", text: "2")
      assert find("tr", text: @tron.title).has_selector?("td", text: "1")
    end
  end

  test "Event page allows you to vote on a movie" do
    find(".movie-list tr", text: @alien.title).click_link("Vote")

    assert_equal 3, @alien.votes.count

    within(".movie-list") do
      assert find("tr", text: @alien.title).has_selector?("td", text: "3")
      assert find("tr", text: @tron.title).has_selector?("td", text: "1")
    end
  end

  test "Event page shows who voted on movies" do
    find(".movie-list tr", text: @lebowski.title).click_link("Vote")

    user_row = find(".vote-list tr", text: @lebowski.title)
    assert user_row.has_content?(@user.name)
    assert user_row.has_content?(Date.today)
  end
end
