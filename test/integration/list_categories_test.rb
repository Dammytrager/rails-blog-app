require "test_helper"

class ListCategoriesTest < ActionDispatch::IntegrationTest

  def setup
    @category1 = Category.create(name: 'Fitness')
    @category2 = Category.create(name: 'Sports')
  end

  test "get categories listing" do
    get categories_path
    assert_select 'h5.card-title', text: @category1.name
    assert_select 'a[href=?]', category_path(@category1), text: 'Show'
    assert_select 'h5.card-title', text: @category2.name
    assert_select 'a[href=?]', category_path(@category2), text: 'Show'
  end
end
