module SharedMethods extend ActiveSupport::Concern
  def self.included(base)
    base.extend ClassMethods
    base.class_eval do
      scope :disabled, -> { where(disabled: true) }
    end
  end
  
  module ClassMethods
    def available_object(id, user_id)
      obj = find(id)
      return obj if User.find(user_id) == obj.user
    end
    
    def recent
      order('created_at desc')
    end
 
    def p(page)
      paginate(page: page, per_page: @per_page)
    end
  end
end