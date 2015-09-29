require "test_helper"

class EventsTest < ActionDispatch::IntegrationTest
  test "Event page shows all movies" do
    january = events(:january)

    visit event_path(january)

    assert page.has_content?("Alien")
    assert page.has_content?("Big Lebowski")
    assert page.has_content?("Tron: Legacy")
  end

  test "Event page allows you to suggest a movie" do
    january = events(:january)

    visit event_path(january)

    within("#new_movie") do
      fill_in "Title", with: "Star Wars"
      fill_in "URL", with: "http://example.com"
      click_button "Suggest Movie"
    end

    assert page.has_content?("Star Wars")
  end

  test "Event page does not let you create an invalid movie" do
    january = events(:january)

    visit event_path(january)

    within("#new_movie") do
      click_button "Suggest Movie"
    end

    assert page.has_content?("Title can't be blank")
    assert page.has_content?("URL can't be blank")
  end

  test "Event page allows you to delete a movie" do
    january = events(:january)

    visit event_path(january)

    find("li", text: "Alien").click_link("Delete")

    refute page.has_content?("Alien")
  end
end
