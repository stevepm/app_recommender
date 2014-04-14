require 'spec_helper'

feature 'Homepage' do
  before do
    DB[:apps].delete
  end

  scenario 'Adding apps to the database' do
    visit '/'

    fill_in('app_name', :with=>'1Password')
    fill_in('app_url', :with=>'1password.com')
    click_on 'Add app'

    expect(page).to have_content('1Password')
    expect(page).to have_content('1password.com')
  end
end