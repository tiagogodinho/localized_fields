require "localized_fields/version"

require 'mongoid'
require 'action_view'

module LocalizedFields
  module FormHelpers
    def localized_fields(field = nil, options = {}, &block)
      if field
        field_name = "#{field}_translations"
        object = @object.send(field_name)
        name = "#{object_name}[#{field_name}]"
        
        @template.fields_for(name, object, options.merge(:builder => LocalizedFields::FormBuilder), &block).html_safe
      else
        output = ''
        
        I18n.available_locales.each do |language|
          output << @template.fields_for(object_name, @object, options.merge(:builder => LocalizedFields::FormBuilder, :language => language), &block)
        end
        
        output.html_safe
      end
    end
  end
  
  class FormBuilder < ActionView::Helpers::FormBuilder
    def language
      @options[:language] if @options[:language]
    end
    
    def label(attribute, options = {})
      if @options.has_key?(:language)
        language = @options[:language]
        
        super(attribute, :for => "#{object_name}_#{attribute}_translations_#{language}").html_safe
      else
        field_name = @object_name.match(/.*\[(.*)_translations\]/)[1].capitalize
        super(attribute, field_name, options).html_safe
      end
    end
    
    def text_field(attribute, options = {})
      if @options.has_key?(:language)
        language = @options[:language]
        
        translations = @object.send("#{attribute}_translations") || {}
        
        value = translations.has_key?(language.to_s) ? translations[language.to_s] : nil
        
        super(attribute, :value => value, :id => "#{object_name}_#{attribute}_translations_#{language}", :name => "#{object_name}[#{attribute}_translations][#{language}]").html_safe
      else
        value = @object ? @object[attribute.to_s] : nil
        super(attribute, :value => value).html_safe
      end
    end
    
    def text_area(attribute, options = {})
      if @options.has_key?(:language)
        language = @options[:language]
        
        super(attribute, :id => "#{object_name}_#{attribute}_translations_#{language}", :name => "#{object_name}[#{attribute}_translations][#{language}]").html_safe
      else
        super(attribute, options).html_safe
      end
    end
  end
end

ActionView::Helpers::FormBuilder.send :include, LocalizedFields::FormHelpers
