module Learndot
  module Records
    class Organization < UnicornRecord
      unicorn_attr :name, :app_name, :host_url, :welcome_message, :organization_picture_id
      unicorn_has_many :courses

      validates_presence_of :app_name, :name, :host_url

      def add_user(user)
        unicorn.post('/organizationRole', {userId: user.id, organizationId: self.id, organizationRole: 'User'})
      end

      def add_admin(user)
        unicorn.post('/organizationRole', {userId: user.id, organizationId: self.id, organizationRole: 'Admin'})
      end
    end
  end
end