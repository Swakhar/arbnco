class CreateOfficialDocuments
  attr_reader :file_data

  def initialize(file_data)
    @file_data = file_data
  end

  def self.call(file_data)
    new(file_data).create_documents
  end

  def create_documents
    metadata = {}
    total_hash = {}
    File.foreach(file_data).with_index do |line, index|
      next if line.include?('$') || line.include?('..')

      if line.first == '"'
        total_hash.merge!(
            index => {
                name: @split_lines.first.strip,
                type: @split_lines.last.strip,
                data: metadata,
            }
        ) if metadata.present?
        @split_lines = nil
        metadata = {}
        @split_lines ||= line.split('=')
      else
        metadata.merge!(
            {
                line.split('=').first.strip => line.split('=').last.strip
            }
        )
      end
    end

    OfficialDocument.create(metadata: total_hash)
  end
end
