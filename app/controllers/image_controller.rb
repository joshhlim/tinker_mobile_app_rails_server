class ImagesController < ApplicationController
  # def show
  #   @image = image.find(params[:id])
  #   send_data @image.data, :filename => @image.filename, :type => @image.content_type
  # end

    def create
    create_action_failure and return unless params.has_key?(:image) && params[:image].present?
    @image = Image.new(image_params)
    if @image.save
      render json: @image.to_json
    else
      create_action_failure
    end
  end



  # for delete you can set the @image.image = nil and then @image.save and
  # that will delete the image

  private
  def image_params
    params.require(:image).permit(:image)
  end

  def create_action_failure
    head 422
  end

end
