class AddAttachmentDiplomaToResult < ActiveRecord::Migration[5.0]
  def change
    add_attachment :results, :diploma
  end
end
