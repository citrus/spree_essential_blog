#! /usr/bin/env ruby
# encoding: UTF-8

require 'test_helper'

class Admin::DisqusIntegrationTest < ActiveSupport::IntegrationCase
  
  should "have a link to disqus config" do
    visit admin_configurations_path
    within "#content table.index" do
      assert has_link?("Disqus Settings", :href => edit_admin_disqus_settings_path)
    end
  end
  
  should "edit disqus config" do
    visit edit_admin_disqus_settings_path
    within "form.edit_blog_configuration" do  
      fill_in "Disqus Shortname", :with => "its-just-a-test"
      click_button "Update"
    end
    assert_equal current_path, admin_disqus_settings_path
    assert_seen "its-just-a-test", :within => "#content .member-list h3"
  end
  
end
