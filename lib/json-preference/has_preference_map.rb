module JsonPreference
  module HasJsonPreferences
    extend ActiveSupport::Concern

    included do
      class_attribute :_preferences_attribute
      class_attribute :_old_preferences_attribute
      self._old_preferences_attribute = :preferences # TODO: This is a migration. Please remove it when we move to json-preferences entirely
      self._preferences_attribute = :json_preferences
      class_attribute :_preference_map
      self._preference_map = JsonPreference::Preferenzer.new
    end

    module ClassMethods
      def preference_groups
        _preference_map.preference_groups
      end

      def preferences(storage_attribute = nil, &block)
        self._preferences_attribute = storage_attribute || self._preferences_attribute
        _preference_map.draw(&block)
        build_preference_definitions
      end

      def preference_definition(name)
        _preference_map.definition_for(name)
      end

      def preference_names
        _preference_map.all_preference_names.map(&:to_sym)
      end

      private

      def build_preference_definitions
        _preference_map.all_preference_definitions.each do |preference|
          key = preference.name.to_s
          define_method("#{key}=") do |value|
            write_preference_attribute(self.class._preferences_attribute, key, self.class.preference_definition(key).value(value))
          end

          define_method(key) do
            value = read_preference_attribute(self.class._preferences_attribute, key)
            self.class.preference_definition(key).value(value)
          end

          if preference.boolean?
            define_method("#{key}?") do
              value = read_preference_attribute(self.class._preferences_attribute, key)
              self.class.preference_definition(key).value(value)
            end
          end

        end
      end
    end

    protected

    def read_preference_attribute(store_attribute, key)
      attribute = send(store_attribute)

      if attribute.nil?
        send :"#{store_attribute}=", {}
        attribute = send(store_attribute)
      end

      # TODO: This is a migration. Please remove it when we move to json-preferences entirely
      if attribute.empty?
        old_attribute = send(self._old_preferences_attribute)

        return nil if old_attribute.nil?

        parsed_old_attribute = YAML::load(old_attribute)

        parsed_old_attribute.each do |key, value|
          attribute[key] = value
        end

        update_column(store_attribute, attribute)
      end

      attribute[key]
    end

    def write_preference_attribute(store_attribute, key, value)
      attribute = send(store_attribute)

      if attribute.nil?
        send :"#{store_attribute}=", {}
        attribute = send(store_attribute)
      end

      if value != attribute[key]
        send :"#{store_attribute}_will_change!"
        attribute[key] = value
      end
    end

  end
end
