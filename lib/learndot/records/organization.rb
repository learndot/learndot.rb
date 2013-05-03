module Learndot
  module Records
    class Organization < UnicornRecord
      unicorn_attr :name, :app_name, :host_url, :welcome_message

      validates_presence_of :app_name, :name, :host_url
    end
  end
end