class AddNewToTranscript < ActiveRecord::Migration[7.0]
  def change
    add_column :transcripts, :transcript_text, :text
  end
end
