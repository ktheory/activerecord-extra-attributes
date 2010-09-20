module KTheory
  module ExtraAttributes
    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      def extra_attribute(name, type = :string, options = {})

        name, type, default = name.to_sym, type.to_sym, options[:default]

        unless ExtraAttribute::TYPES.key?(type)
          raise "Unknown ExtraAttribute type #{type}"
        end

        has_many :extra_attributes, :as => :model, :dependent => :destroy
        cattr_accessor :extra_attribute_options

        self.extra_attribute_options ||= {}
        self.extra_attribute_options[name] = {:type => type, :default => default}

        # Reader method
        define_method name do
          if ea = self.extra_attributes.find_by_name(name.to_s)
            ExtraAttribute.cast(ea.value, extra_attribute_options[name][:type])
          else
            # Fall back to the default
            default = extra_attribute_options[name][:default]
            default.is_a?(Proc) ? default.call(self) : default
          end
        end

        # Writer method
        define_method "#{name}=" do |value|
          if new_record?
            extra_attributes.build(:name => name.to_s, :value => value)
          else
            ea =  extra_attributes.find_or_create_by_name(name.to_s)
            ea.update_attributes(:value => value)
          end
          value
        end

        # Test method
        define_method "#{name}?" do
          !!self.send(name)
        end
      end
    end
  end
end

