class CreateCoins < ActiveRecord::Migration[5.2]
  def change
    create_table :coins do |t|
      t.string :description
      t.string :aconym
      t.string :url_image

      t.timestamps
    end
  end
end
