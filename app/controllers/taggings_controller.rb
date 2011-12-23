class TaggingsController < ApplicationController
  def destroy
    @tagging = ActsAsTaggableOn::Tagging.find(params[:id])
    @taggings = ActsAsTaggableOn::Tagging.where(:taggable_id => @tagging.taggable_id)
    @tagging.destroy
    respond_to do |format|
      format.js { render 'update_tag_list' }
    end
  end
end
