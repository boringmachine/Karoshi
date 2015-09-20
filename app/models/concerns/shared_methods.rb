module SharedMethods extend ActiveSupport::Concern
  def self.included(base)
    base.extend ClassMethods
    base.class_eval do
      scope :disabled, -> { where(disabled: true) }
    end
  end
  
  module ClassMethods
    def available_object(id, user_id)
      obj = find(id).taint
      return obj.untaint if User.find(user_id) == obj.user
    end
    
    def recent
      order('created_at desc').untaint
    end
 
    def p(page)
      paginate(page: page, per_page: @per_page).untaint
    end
  end
end