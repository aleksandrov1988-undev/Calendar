class EventValidator < ActiveModel::Validator
  def validate(record)
    if record.new_record? && record.start_at.is_a?(Time) && record.start_at < Time.now
      record.errors.add(:start_at, :no_past)
    end
    if record.mode==0 && record.mask!=0 || record.mode==1 && record.mask>127 || record.mode==2 && record.mask > 2147483647
      record.errors.add(:mask, :invalid)
    end
  end
end