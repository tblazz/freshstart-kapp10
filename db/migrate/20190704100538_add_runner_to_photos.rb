class AddRunnerToPhotos < ActiveRecord::Migration[5.0]
  def change
    add_reference :photos, :runner, foreign_key: true
  end
end
