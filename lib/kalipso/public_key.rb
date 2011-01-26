module Kalipso
  module PublicKey
  
    class Base < Jaysus::Base
      primary_key :id
      attribute :id
      attribute :key
      attribute :user_id
      attribute :created_at
      attribute :updated_at
    end
  
    class Local < Base
      include Jaysus::Local
    end
  
    class Remote < Base
      include Jaysus::Remote
    end
  
  end
end