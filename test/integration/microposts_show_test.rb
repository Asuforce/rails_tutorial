class MicropostsShowTest < ActionDispatch::IntegrationTest

  def setup
    @micropost = microposts(:orange)
    @text = 'Micropost'
  end

  test "redirect to micropost show" do
    get micropost_path(@micropost)

    assert_template 'microposts/show'
    assert_select 'title', full_title(@text)
    assert_select 'h3', text: @text
    assert_select 'a>img.gravatar'
  end
end
