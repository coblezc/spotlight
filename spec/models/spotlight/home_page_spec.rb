require 'spec_helper'

describe Spotlight::HomePage do
  let(:home_page) { FactoryGirl.create(:home_page) }
  it {should_not be_feature_page}
  it {should_not be_about_page}
  it "should display the sidebar" do
    expect(home_page.display_sidebar).to be_true
  end
  it "should be published" do
    expect(home_page.published).to be_true
  end
  describe "content" do
    it "should include default text" do
      expect(home_page.content).to match /#{Spotlight::HomePage.default_content_text}/
    end
    it "should be parsible JSON that includes the default text" do
      json = JSON.parse(home_page.content)
      expect(json).to be_a Hash
      expect(json["data"].first["data"]["text"]).to eq Spotlight::HomePage.default_content_text
    end
  end
end
