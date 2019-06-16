class OfficialDocumentsController < ApplicationController
  def index
    @official_documents = OfficialDocument.all
  end

  def new
    @official_document = OfficialDocument.new
  end

  def create
    params[:official_document][:metadata].each_with_index do |_value, index|
      OfficialDocumentCreationJob.
        perform_now(params[:official_document][:metadata][index].path)
    end

    SendEmailToUser.call(params[:email])

    redirect_to official_documents_path, flash: { notice: 'A inp file Processed Successfully' }
  end

  def show
    official_document = OfficialDocument.find(params[:id])
    respond_to do |format|
      format.html { @official_document = official_document }
      format.inp { @official_document = official_document }
    end
  end
end
