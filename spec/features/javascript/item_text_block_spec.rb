require "spec_helper"

feature "Record Thumbnail Block" do
  let(:exhibit_curator) { FactoryGirl.create(:exhibit_curator) }
  before { login_as exhibit_curator }

  scenario "should allow you to add a thumbnail to a page within an exhibit", :js => true do
    pending("Passing locally but Travis is thowing intermittent error because it doesn't seem to wait for form to be submitted.") if ENV["ci"]
    # create page
    visit '/'
    click_link exhibit_curator.email
    within '.dropdown-menu' do
      click_link 'Curation'
    end
    click_link "Feature pages"
    click_button "Add new Page"

    expect(page).to have_content("Page was successfully created.", visible: true)
    within("li.dd-item") do
      click_link "Edit"
    end
    # fill in title
    fill_in "feature_page_title", :with => "Exhibit Title"
    # click to add widget
    find("[data-icon='add']").click
    # click the Record Thumbnail widget
    expect(page).to have_css("a[data-type='item-text']")
    find("a[data-type='item-text']").click
    # fill in the record ID field
    expect(page).to have_css("input#item-id")
    fill_in "item-id", :with => "dq287tq6352"
    # create the page
    click_button("Save changes")
    # veryify that the page was created
    expect(page).to have_content("Page was successfully updated.", visible: true)
    # visit the show page for the document we just saved
    visit spotlight.feature_page_path(id: Spotlight::FeaturePage.last)
    # veryify that the record thumbnail widget is displaying an image from the document.
    within(:css, ".item-text") do
      expect(page).to have_css(".thumbnail")
      expect(page).to have_css(".thumbnail a img")
      expect(page).not_to have_css(".title")
    end
  end
  scenario "should allow you to optionally display the title with the image", :js => true do
    pending("Passing locally but Travis is thowing intermittent error because it doesn't seem to wait for form to be submitted.") if ENV["ci"]
    # create page
    visit '/'
    click_link exhibit_curator.email
    within '.dropdown-menu' do
      click_link 'Curation'
    end
    click_link "Feature pages"
    click_button "Add new Page"

    expect(page).to have_content("Page was successfully created.", visible: true)
    within("li.dd-item") do
      click_link "Edit"
    end
    # fill in title
    fill_in "feature_page_title", :with => "Exhibit Title"
    # click to add widget
    find("[data-icon='add']").click
    # click the Record Thumbnail widget
    expect(page).to have_css("a[data-type='item-text']")
    find("a[data-type='item-text']").click
    # fill in the record ID field
    expect(page).to have_css("input#item-id")
    fill_in "item-id", :with => "dq287tq6352"
    # display the title
    check("Display title")
    # create the page
    click_button("Save changes")
    # veryify that the page was created
    expect(page).to have_content("Page was successfully updated.", visible: true)
    # visit the show page for the document we just saved
    visit spotlight.feature_page_path(id: Spotlight::FeaturePage.last)
    # veryify that the record thumbnail widget is displaying image and title from the requested document.
    within(:css, ".item-text") do
      expect(page).to have_css(".thumbnail")
      expect(page).to have_css(".thumbnail a img")
      expect(page).to have_css(".title")
      expect(page).to have_content("L'AMERIQUE")
    end
  end
  scenario "should allow you to add text to the image", :js => true do
    pending("Passing locally but Travis is thowing intermittent error because it doesn't seem to wait for form to be submitted.") if ENV["ci"]
    # create page
    visit '/'
    click_link exhibit_curator.email
    within '.dropdown-menu' do
      click_link 'Curation'
    end
    click_link "Feature pages"
    click_button "Add new Page"

    expect(page).to have_content("Page was successfully created.", visible: true)
    within("li.dd-item") do
      click_link "Edit"
    end
    # fill in title
    fill_in "feature_page_title", :with => "Exhibit Title"
    # click to add widget
    find("[data-icon='add']").click
    # click the Record Thumbnail widget
    expect(page).to have_css("a[data-type='item-text']")
    find("a[data-type='item-text']").click
    # fill in the record ID field
    expect(page).to have_css("input#item-id")
    fill_in "item-id", :with => "dq287tq6352"
    # fill in the text area
    fill_in "item-text", with: "Some text to annotate this image."
    # create the page
    click_button("Save changes")
    # veryify that the page was created
    expect(page).to have_content("Page was successfully updated.", visible: true)
    # visit the show page for the document we just saved
    visit spotlight.feature_page_path(id: Spotlight::FeaturePage.last)
    # veryify that the record thumbnail widget is displaying image and title from the requested document.
    within(:css, ".item-text") do
      expect(page).to have_content "Some text to annotate this image."
    end
  end
  scenario "should allow you to choose which side the text will be on", :js => true do
    pending("Passing locally but Travis is thowing intermittent error because it doesn't seem to wait for form to be submitted.") if ENV["ci"]
    # create page
    visit '/'
    click_link exhibit_curator.email
    within '.dropdown-menu' do
      click_link 'Curation'
    end
    click_link "Feature pages"
    click_button "Add new Page"

    expect(page).to have_content("Page was successfully created.", visible: true)
    within("li.dd-item") do
      click_link "Edit"
    end
    # fill in title
    fill_in "feature_page_title", :with => "Exhibit Title"
    # click to add widget
    find("[data-icon='add']").click
    # click the Record Thumbnail widget
    expect(page).to have_css("a[data-type='item-text']")
    find("a[data-type='item-text']").click
    # fill in the record ID field
    expect(page).to have_css("input#item-id")
    fill_in "item-id", :with => "dq287tq6352"
    # fill in the text area
    fill_in "item-text", with: "Some text to annotate this image."
    # Select to align the text right
    choose "Right"
    # create the page
    click_button("Save changes")
    # veryify that the page was created
    expect(page).to have_content("Page was successfully updated.", visible: true)
    # visit the show page for the document we just saved
    visit spotlight.feature_page_path(id: Spotlight::FeaturePage.last)
    # veryify that the record thumbnail widget is displaying image and title from the requested document.
    within(:css, ".item-text") do
      expect(page).to have_content "Some text to annotate this image."
      # should pull the image block the opposite direction of the configured text.
      expect(page).to have_css(".image-block.pull-left")
    end
  end
end
