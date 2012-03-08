#! /usr/bin/env ruby
#encoding: UTF-8

require 'test_helper'

class Spree::Blogs::Admin::DisqusIntegrationTest < SpreeEssentials::IntegrationCase

  should "have a link to disqus config" do
    visit spree.admin_configurations_path
    within "#content table.index" do
      assert has_link?("Disqus Settings", :href => spree.edit_admin_disqus_settings_path)
    end
  end

  should "edit disqus config" do
    visit spree.edit_admin_disqus_settings_path
    fill_in "Disqus Shortname", :with => "its-just-a-test"
    click_button "Update"
    assert_equal current_path, spree.admin_disqus_settings_path
    assert_seen "its-just-a-test", :within => "#content .member-list dd"
  end

end
