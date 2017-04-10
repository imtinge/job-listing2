class CreateResumes < ActiveRecord::Migration[5.0]
  def change
    create_table :resumes do |t|
      t.references :user, foreign_key: true
      t.references :job, foreign_key: true
      t.text :content
      t.string :attachment

      t.timestamps
    end
  end
end
