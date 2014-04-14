require 'spec_helper'

describe 'App Repository' do
  before do
    DB[:apps].delete
  end

  it 'Can add an app' do
    id = AppRepository.create?('1Password', 'google.com')
    app_name = AppRepository.find(id).app_name
    app_url = AppRepository.find(id).app_url
    expect(app_name).to eq('1Password')
    expect(app_url).to eq('google.com')
  end

  it 'can add an app without a url' do
    id = AppRepository.create?('1Password')
    app_name = AppRepository.find(id).app_name
    app_url = AppRepository.find(id).app_url
    expect(app_name).to eq('1Password')
    expect(app_url).to eq('None provided')
  end

  it 'returns false if app name is already taken' do
    id = AppRepository.create?('1Password')
    expect(AppRepository.create?('1Password')).to eq(false)
  end

end