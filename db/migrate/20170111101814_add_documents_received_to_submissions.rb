class AddDocumentsReceivedToSubmissions < ActiveRecord::Migration[5.0]
  def change
    add_column :submissions, :documents_received, :string
  end
end
