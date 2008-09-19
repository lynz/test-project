class ViewerController < ApplicationController

  in_place_edit_for :page, :body

  def show
    @page = Page.find_by_name(params[:name])
    @subpages = @page.subpages
    @pagetitle = @page.title
    login_required if @page.admin?
  end
  
  def get_unformatted_text
    @page = Page.find(params[:id])
    render :text => @page.body(:source)
  end
end
