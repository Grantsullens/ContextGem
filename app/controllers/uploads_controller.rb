class UploadsController < ApplicationController
  def new
    # Renders the file upload form
  end

  def create
    uploaded_file = params[:file]
    file_name = uploaded_file.original_filename

    obj = S3_BUCKET.object(file_name)
    obj.upload_file(uploaded_file.tempfile)

    render json: { url: obj.public_url }, status: :ok
  rescue StandardError => e
    render json: { error: e.message }, status: :unprocessable_entity
  end
end
