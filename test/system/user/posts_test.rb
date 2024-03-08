require "application_system_test_case"

class User::PostsTest < ApplicationSystemTestCase
  setup do
    @user_post = user_posts(:one)
  end

  test "visiting the index" do
    visit user_posts_url
    assert_selector "h1", text: "User/Posts"
  end

  test "creating a Post" do
    visit user_posts_url
    click_on "New User/Post"

    fill_in "Title", with: @user_post.title
    click_on "Create Post"

    assert_text "Post was successfully created"
    click_on "Back"
  end

  test "updating a Post" do
    visit user_posts_url
    click_on "Edit", match: :first

    fill_in "Title", with: @user_post.title
    click_on "Update Post"

    assert_text "Post was successfully updated"
    click_on "Back"
  end

  test "destroying a Post" do
    visit user_posts_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Post was successfully destroyed"
  end
end
