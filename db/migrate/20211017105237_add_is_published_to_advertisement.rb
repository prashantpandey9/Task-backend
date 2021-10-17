class AddIsPublishedToAdvertisement < ActiveRecord::Migration[6.1]
  def change
    add_column :advertisements, :is_published, :bool, :default => false
    #Ex:- :default =>''
  end
end
