require 'test_helper'

class VotesTest < ActionDispatch::IntegrationTest
  test "Event page shows how many votes each movie has" do
    january = events(:january)
    alien = movies(:alien)
    tron  = movies(:tron)

    visit event_path(january)

    assert find("li", text: alien.title).has_content?("Votes: 2")
    assert find("li", text: tron.title).has_content?("Votes: 1")
  end

  test "Event page allows you to vote on a movie" do
    january = events(:january)
    alien = movies(:alien)

    visit event_path(january)

    movie_row = find("li", text: alien.title)
    movie_row.click_link("Vote")

    assert_equal 3, alien.votes.count
    assert movie_row.has_content?("Votes: 3")
  end
end
