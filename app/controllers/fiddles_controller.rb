class FiddlesController < ApplicationController

  # view for /fiddles/new
  def new
  end

  # view for /fiddles/:id
  def show
    @fiddle = Fiddle.find(params[:id].to_s)
    render :json => @fiddle
  end

  # ajax request
  # params should include the title and content
  # should "return" the new id of the fiddle, or alt some sort of failure reason
  def create
    title = params[:title].to_s
    content = params[:content].to_s

    @fiddle = Fiddle.create!(
      title: title,
      revisions: [
        Revision.new(num: 1, content: content)
      ]
    )

    render :json => @fiddle
  end

end

