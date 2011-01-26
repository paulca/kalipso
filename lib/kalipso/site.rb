module Kalipso
  module Site
  
    class Base < Jaysus::Base
      primary_key :id
      attribute :id
      attribute :name
      attribute :user_id
      attribute :created_at
      attribute :updated_at
    end
  
    class Local < Base
      attribute :path
      include Jaysus::Local
    end
  
    class Remote < Base
      include Jaysus::Remote
    end
  
  end
end