module LocalizedFields
  class FormBuilder < ActionView::Helpers::FormBuilder
    def language
      @options[:language] if @options[:language]
    end

    def label(attribute, *args)
      options = args.extract_options!
      text = args[0]
      if @options.has_key?(:language)
        language = @options[:language]
        super(attribute, text, options.merge(for: "#{object_name}_#{attribute}_translations_#{language}")).html_safe
      else
        text ||= @object_name.match(/.*\[(.*)_translations\]/)[1].capitalize
        super(attribute, text, options).html_safe
      end
    end

    def text_field(attribute, options = {})
      attribute, options = create_field(attribute, options)

      super(attribute, options).html_safe
    end

    def text_area(attribute, options = {})
      attribute, options = create_field(attribute, options)

      super(attribute, options).html_safe
    end

    private

    def create_field(attribute, options)
      if @options.has_key?(:language)
        language = @options[:language]

        translations = @object.send("#{attribute}_translations") || {}

        value = translations.has_key?(language.to_s) ? translations[language.to_s] : ""

        options = options.merge(value: value, id: "#{object_name}_#{attribute}_translations_#{language}", name: "#{object_name}[#{attribute}_translations][#{language}]")
      else
        value = @object ? @object[attribute.to_s] : ""

        options = options.merge(value: value)
      end

      return attribute, options
    end
  end
end
