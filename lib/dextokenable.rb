module Dextokenable
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods

    def tokenable(*args, &block)
      args.each do |name|
        before_validation :on => :create do
          self[name] = loop do
            random_token = SecureRandom.urlsafe_base64
            break random_token unless self.class.exists?(name => random_token)
          end
        end
      end
    end

  end
end

class ActiveRecord::Base
  include Dextokenable
end