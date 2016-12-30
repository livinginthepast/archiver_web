module PaginationConcerns
  private

  def current_page
    params[:page] || 1
  end
end
