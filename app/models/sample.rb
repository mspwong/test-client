class Sample < ActiveRecord::Base

  def as_json
    json = super
    json['created_at'] = json['created_at'].to_i
    json['updated_at'] = json['updated_at'].to_i
    json
  end

end