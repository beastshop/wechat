class MessageReceiveLocation < ActiveRecord::Base
  attr_accessible :create_time, :from_user_name, :label, :location_x, :location_y, :msg_id, :msg_type, :origin_source, :scale, :to_user_name
end
