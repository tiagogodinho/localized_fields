module LocalizedFields
  module Helpers
    module FormHelper
      def localized_fields(field = nil, options = {}, &block)
        if field
          field_name = "#{field}_translations"
          object = @object.send(field_name).try(:empty?) ? nil : @object.send(field_name)
          name = "#{object_name}[#{field_name}]"

          @template.fields_for(name, object, options.merge(builder: LocalizedFields::FormBuilder), &block).html_safe
        else
          output = ''

          I18n.available_locales.each do |language|
            output << @template.fields_for(object_name, @object, options.merge(builder: LocalizedFields::FormBuilder, language: language), &block)
          end

          output.html_safe
        end
      end
    end
  end
end