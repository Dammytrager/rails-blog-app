require "test_helper"

class CreateCategoryTest < ActionDispatch::IntegrationTest

  setup do
    @admin_user = User.create(username: 'Flicks', email: 'flicks@gmail.com', password: 'password', user_type: :admin)
    sign_in_as(@admin_user)
  end

  test "get new category form and create category and redirect to category show page" do
    get new_category_path
    assert_response :success

    assert_difference 'Category.count', 1 do
      post categories_path, params: { category: { name: 'Fitness' } }
      assert_response :redirect
    end

    follow_redirect!
    assert_response :success
    assert_match 'Fitness', response.body
  end

  test "get new category form and don't create invalid category" do
    get new_category_path
    assert_response :success

    assert_no_difference 'Category.count' do
      post categories_path, params: { category: { name: '' } }
    end

    assert_match 'error', response.body
    assert_select 'div.alert'
  end
end
