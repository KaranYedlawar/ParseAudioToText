class CreateTranscripts < ActiveRecord::Migration[7.0]
  def change
    create_table :transcripts do |t|
      t.string :analyzed_text

      t.timestamps
    end
  end
end
