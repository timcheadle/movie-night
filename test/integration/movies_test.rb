require 'test_helper'

class MoviesTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:alice)
    sign_in(@user)

    @january = events(:january)
    visit event_path(@january)
  end

  def teardown
    Warden.test_reset!
  end

  test 'Event page shows all movies' do
    alien = movies(:alien)
    tron  = movies(:tron)

    assert page.has_link?(alien.title, href: alien.url)
    assert page.has_link?(tron.title, href: tron.url)
  end

  test "Event page allows you to suggest a movie" do
    within("#new_movie") do
      fill_in "Title", with: "Star Wars"
      fill_in "URL", with: "http://example.com"
      click_button "Suggest Movie"
    end

    assert page.has_link?("Star Wars", href: "http://example.com")
  end

  test "Event page doesn't allow you suggest an invalid movie" do
    within("#new_movie") do
      click_button "Suggest Movie"
    end

    assert page.has_content?("Title can't be blank")
    assert page.has_content?("URL can't be blank")
  end

  test "Event page allows you delete a movie" do
    alien = movies(:alien)

    find("tr", text: alien.title).click_link("Delete")

    refute page.has_link?(alien.title)
  end
end
