require 'rails_helper'

RSpec.describe 'Logging In' do
  it 'can log in with valid credentials' do
    user = User.create(name: 'Frank', email: 'frankthetank@email.com', password: 'test')

    visit root_path

    click_on 'Log In'

    expect(current_path).to eq(login_path)

    fill_in :email, with: user.email
    fill_in :password, with: user.password

    click_on 'Log In'

    expect(current_path).to eq(root_path)

    expect(page).to have_content("Welcome, #{user.email}")
  end

  it "cannot log in with bad credentials" do
    user = User.create(name: 'Frank', email: 'frankthetank@email.com', password: 'test')

    visit login_path

    fill_in :email, with: user.email
    fill_in :password, with: 'incorrect password'

    click_on 'Log In'

    expect(current_path).to eq(login_path)

    expect(page).to have_content('Login failed')

    fill_in :email, with: 'invalid email'
    fill_in :password, with: 'test'

    click_on 'Log In'

    expect(current_path).to eq(login_path)
    expect(page).to have_content('Login failed')
  end
end
