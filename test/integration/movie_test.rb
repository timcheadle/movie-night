require 'test_helper'

class MoviesTest < ActionDispatch::IntegrationTest
  test 'Event page shows all movies' do
    january = events(:january)
    alien = movies(:alien)
    tron  = movies(:tron)

    visit event_path(january)

    assert page.has_link?(alien.title, href: alien.url)
    assert page.has_link?(tron.title, href: tron.url)
  end

  test "Event page allows you to suggest a movie" do
    january = events(:january)

    visit event_path(january)

    within("#new_movie") do
      fill_in "Title", with: "Star Wars"
      fill_in "URL", with: "http://example.com"
      click_button "Suggest Movie"
    end

    assert page.has_link?("Star Wars", href: "http://example.com")
  end

  test "Event page doesn't allow you suggest an invalid movie" do
    january = events(:january)

    visit event_path(january)

    within("#new_movie") do
      click_button "Suggest Movie"
    end

    assert page.has_content?("Title can't be blank")
    assert page.has_content?("URL can't be blank")
  end

  test "Event page allows you delete a movie" do
    january = events(:january)
    alien = movies(:alien)

    visit event_path(january)

    find("li", text: alien.title).click_link("Delete")

    refute page.has_link?(alien.title)
  end
end
