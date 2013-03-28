class RevisionsController < ApplicationController

  def show
    @fiddle = Fiddle.find_by_token(params[:fiddle_id].to_s)
    @revision = @fiddle.revisions.where(num: params[:id].to_s)[0]

    respond_to do |format|
      format.json {
        render :json => {fiddle: @fiddle.as_json(:except => :revisions), revision: @revision}
      }
      format.html
    end
  end

  def create
    content = params[:content].to_s

    @fiddle = Fiddle.find_by_token(params[:fiddle_id])

    @revision = Revision.create!(
      content: content,
      num: @fiddle.num_revisions + 1,
      fiddle: @fiddle
    )

    @fiddle.inc(:num_revisions, 1)

    @fiddle.save!()

    render :json => @revision
  end
end

