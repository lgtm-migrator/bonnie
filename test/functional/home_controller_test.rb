require 'test_helper'

class HomeControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers
  setup do
    dump_database
    users_set = File.join("users", "base_set")
    collection_fixtures(users_set)
    @user = User.by_email('bonnie@example.com').first
    @user.init_personal_group
    @user.save
    @user_unapproved = User.by_email('user_unapproved@example.com').first
    @user_unapproved.init_personal_group
    @user_unapproved.save
  end

  test "index" do
    sign_in @user
    get :index
    assert_response :success
  end

  test "index fails unapproved" do
    sign_in @user_unapproved
    get :index
    assert_response :redirect
    assert_equal "Your account is not activated yet.  You will receive an email when your account has been activated.", flash[:alert]
  end

  test "show" do
    sign_in @user
    get :show
    assert_response :success
  end

  test "registered_not_active" do
    get :registered_not_active
    assert_response :success
    assert_match 'You have registered for a Bonnie account.', response.body
    assert_match 'You have registered for a Bonnie account.', response.body
    msg = 'You have registered for a Bonnie account. '\
    'The Bonnie admin team is looking at your account and will approve it shortly. '\
    'Please refrain from logging in to Bonnie until you have received confirmation your account is approved. '\
    'In the meantime, you can view <a target="_blank" href="/resource/Bonnie_user_guide.pdf">the user guide</a>. '\
    'If you have received an email your account has been activated you can login <a href="/users/saml/sign_in">here</a>.'
    assert_match msg, response.body
  end

  test "show fails unapproved" do
    sign_in @user_unapproved
    get :index
    assert_response :redirect
    assert_equal "Your account is not activated yet.  You will receive an email when your account has been activated.", flash[:alert]
  end

  test "switch_group successfully" do
    group = Group.new(name: 'semanticbits')
    group.save
    @user.groups << group
    @user.save
    assert_equal @user.current_group.name, @user.email
    sign_in @user
    get :switch_group, params: { group_id: group.id}
    assert_response :redirect
    assert_nil flash[:error]
  end

  test "switch_group fails when tried to access a group which is not yet assigned" do
    group = Group.new(name: 'inaccessible')
    group.save
    sign_in @user
    get :switch_group, params: { group_id: group.id}
    assert_response :redirect
    assert_equal flash[:error][:title], 'Error switching the group'
    assert_equal flash[:error][:body], 'You do not have access to this group. Please contact group owner to get the access.'
  end

end
