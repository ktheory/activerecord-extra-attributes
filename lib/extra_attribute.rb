class ExtraAttribute < ActiveRecord::Base

  TYPES = {
    :string    => Proc.new { |v| v.to_s },
    :integer   => Proc.new { |v| v.to_i },
    :boolean   => Proc.new { |v| v && !['false', '0', ''].include?(v.to_s.downcase)},
    :date      => Proc.new { |v| Date.parse(v) },
    :timestamp => Proc.new { |v| Time.parse(v) }
  }

  belongs_to :model, :polymorphic => true
  # NB: it's not possible to validate the presence of the model, model_id, or
  # model_type if the association is built off an unsaved model.
  validates_presence_of :name

  def self.cast(value, type)
    TYPES[type].call(value)
  end
end