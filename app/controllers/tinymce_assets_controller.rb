class TinymceAssetsController < ApplicationController
  def create
    image = EditorImage.create(params.permit(:file, :alt))
    render json: {
      image: {
        url: image.file.url,
      },
    }, content_type: "text/html"
  end
end
