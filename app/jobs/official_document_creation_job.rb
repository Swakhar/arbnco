class OfficialDocumentCreationJob < ApplicationJob
  queue_as :default

  def perform(file_data)
    CreateOfficialDocuments.call(file_data)
  end
end
