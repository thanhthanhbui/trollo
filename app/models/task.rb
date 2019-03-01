class Task < ApplicationRecord
  belongs_to :list, dependent: :destroy
end
