module BlogsHelper
  def blog_button_text
    return 'Update Blog' if %w(edit update).include? params[:action]
    'Create Blog'
  end
end