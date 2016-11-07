class Storage < ActiveRecord::Base
  belongs_to :user
  belongs_to :letter

  STORAGE_MAX = 5

  validate :user_storages_size_validate

  def user_storages_size_validate
    if self.user && self.user.storages.size >= STORAGE_MAX
      errors.add(:base, "ニュース保管登録は5つまでです。")
    end
  end
end
