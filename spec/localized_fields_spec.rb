require 'spec_helper'

describe 'LocalizedFields' do
  let(:post) { Post.new }
  let(:template) { ActionView::Base.new }
  let(:builder) { ActionView::Helpers::FormBuilder.new(*builder_args) }
  let(:builder_args) do
    args =  [:post, post, template, {}]
    args += [proc {}] if rails3?
    args
  end

  before do
    template.output_buffer = ''
    I18n.available_locales = [:en, :pt]
  end

  context 'form helpers with html tags' do
    it 'returns html tags with label and text_field' do
      output = builder.localized_fields do |localized_field|
        html =  %{<dl class="field">}
        html <<  %{<dt>#{localized_field.label(:title)}</dt>}
        html <<  %{<dd>#{localized_field.text_field(:title)}</dd>}
        html << %{</dl>}
        html.html_safe
      end

      expected =  %{<dl class="field">}
      expected <<  %{<dt><label for="post_title_translations_en">Title</label></dt>}
      expected <<  %{<dd><input id="post_title_translations_en" name="post[title_translations][en]" value="" type="text" /></dd>}
      expected << %{</dl>}
      expected << %{<dl class="field">}
      expected <<  %{<dt><label for="post_title_translations_pt">Title</label></dt>}
      expected <<  %{<dd><input id="post_title_translations_pt" name="post[title_translations][pt]" value="" type="text" /></dd>}
      expected << %{</dl>}

      expect(output).to eq(expected)
    end

    it 'returns html tags with text_field' do
      output = builder.localized_fields do |localized_field|
          %{<div>#{localized_field.text_field(:title).html_safe}</div>}.html_safe
      end

      expected =  %{<div><input id="post_title_translations_en" name="post[title_translations][en]" value="" type="text" /></div>}
      expected << %{<div><input id="post_title_translations_pt" name="post[title_translations][pt]" value="" type="text" /></div>}

      expect(output).to eq(expected)
    end

    it 'returns html tags with text_field for :en' do
      output = builder.localized_fields(:title) do |localized_field|
          %{<div>#{localized_field.text_field(:en).html_safe}</div>}.html_safe
      end

      expected = %{<div><input value="" type="text" name="post[title_translations][en]" id="post_title_translations_en" /></div>}

      expect(output).to eq(expected)
    end
  end

  describe 'language' do
    it 'returns the language' do
      output = builder.localized_fields do |localized_field|
        %{<h2>#{localized_field.language}</h2>}.html_safe
      end

      expected = %{<h2>en</h2><h2>pt</h2>}

      expect(output).to eq(expected)
    end
  end

  describe 'label' do
    it 'returns a label tag for en' do
      output = builder.localized_fields(:title) do |localized_field|
        localized_field.label :en
      end

      expected = %{<label for="post_title_translations_en">Title</label>}

      expect(output).to eq(expected)
    end

    it 'returns a label tag with custom text' do
      output = builder.localized_fields(:title) do |localized_field|
        localized_field.label :en, "The title in english"
      end

      expected = %{<label for="post_title_translations_en">The title in english</label>}

      expect(output).to eq(expected)
    end

    it 'returns a label tag with custom text and options' do
      output = builder.localized_fields(:title) do |localized_field|
        localized_field.label :en, "The title in english", class: "field"
      end

      expected = %{<label class="field" for="post_title_translations_en">The title in english</label>}

      expect(output).to eq(expected)
    end

    it 'returns a label tag for all languages' do
      output = builder.localized_fields do |localized_field|
        localized_field.label :title
      end

      expected =  %{<label for="post_title_translations_en">Title</label>}
      expected << %{<label for="post_title_translations_pt">Title</label>}

      expect(output).to eq(expected)
    end

    it 'returns label tags with options' do
      output = builder.localized_fields do |localized_field|
        localized_field.label :title, class: 'field'
      end

      expected =  %{<label class="field" for="post_title_translations_en">Title</label>}
      expected << %{<label class="field" for="post_title_translations_pt">Title</label>}

      expect(output).to eq(expected)
    end
  end

  describe 'text_field' do
    it 'returns a text_field tag for en' do
      output = builder.localized_fields(:title) do |localized_field|
        localized_field.text_field :en
      end

      expected = %{<input value="" type="text" name="post[title_translations][en]" id="post_title_translations_en" />}

      expect(output).to eq(expected)
    end

    it 'returns a text_field tag for all languages' do
      output = builder.localized_fields do |localized_field|
        localized_field.text_field :title
      end

      expected =  %{<input id="post_title_translations_en" name="post[title_translations][en]" value="" type="text" />}
      expected << %{<input id="post_title_translations_pt" name="post[title_translations][pt]" value="" type="text" />}

      expect(output).to eq(expected)
    end

    it 'returns text_field tags with options' do
      output = builder.localized_fields do |localized_field|
        localized_field.text_field :title, class: 'field'
      end

      expected =  %{<input class="field" id="post_title_translations_en" name="post[title_translations][en]" value="" type="text" />}
      expected << %{<input class="field" id="post_title_translations_pt" name="post[title_translations][pt]" value="" type="text" />}

      expect(output).to eq(expected)
    end

    context 'post with values' do
      before do
        post.stub(:title_translations).and_return({ 'en' => 'title en', 'pt' => 'title pt' })
      end

      it 'returns a text_area tag for en' do
        output = builder.localized_fields(:title) do |localized_field|
          localized_field.text_field :en
        end

        expected =  %{<input value="title en" type="text" name="post[title_translations][en]" id="post_title_translations_en" />}

        expect(output).to eq(expected)
      end

      it 'returns a text_area tag for ja' do
        output = builder.localized_fields(:title) do |localized_field|
          localized_field.text_field :ja
        end

        expected =  %{<input value="" type="text" name="post[title_translations][ja]" id="post_title_translations_ja" />}

        expect(output).to eq(expected)
      end

      it 'returns a text_area tag for all languages' do
        output = builder.localized_fields do |localized_field|
          localized_field.text_field :title
        end

        expected =  %{<input id="post_title_translations_en" name="post[title_translations][en]" value="title en" type="text" />}
        expected << %{<input id="post_title_translations_pt" name="post[title_translations][pt]" value="title pt" type="text" />}

        expect(output).to eq(expected)
      end
    end
  end

  describe 'text_area' do
    it 'returns a text_area tag for en' do
      output = builder.localized_fields(:title) do |localized_field|
        localized_field.text_area :en, value: 'My Value'
      end

      expected =  %{<textarea name="post[title_translations][en]" id="post_title_translations_en">\n}
      expected << %{My Value</textarea>}

      expect(output).to eq(expected)
    end

    it 'returns a text_area tag for all languages' do
      output = builder.localized_fields do |localized_field|
        localized_field.text_area :title
      end

      expected =  %{<textarea id="post_title_translations_en" name="post[title_translations][en]">\n}
      expected << %{</textarea>}
      expected << %{<textarea id="post_title_translations_pt" name="post[title_translations][pt]">\n}
      expected << %{</textarea>}

      expect(output).to eq(expected)
    end

    it 'returns text_area tags with options' do
      output = builder.localized_fields do |localized_field|
        localized_field.text_area :title, class: 'field'
      end

      expected =  %{<textarea class="field" id="post_title_translations_en" name="post[title_translations][en]">\n}
      expected << %{</textarea>}
      expected << %{<textarea class="field" id="post_title_translations_pt" name="post[title_translations][pt]">\n}
      expected << %{</textarea>}

      expect(output).to eq(expected)
    end

    context 'post with values' do
      before do
        post.stub(:title_translations).and_return({ 'en' => 'title en', 'pt' => 'title pt' })
      end

      it 'returns a text_area tag for en' do
        output = builder.localized_fields(:title) do |localized_field|
          localized_field.text_area :en
        end

        expected =  %{<textarea name="post[title_translations][en]" id="post_title_translations_en">\ntitle en}
        expected << %{</textarea>}

        expect(output).to eq(expected)
      end

      it 'returns a text_area tag for ja' do
        output = builder.localized_fields(:title) do |localized_field|
          localized_field.text_area :ja
        end

        expected =  %{<textarea name="post[title_translations][ja]" id="post_title_translations_ja">\n}
        expected << %{</textarea>}

        expect(output).to eq(expected)
      end

      it 'returns a text_area tag for all languages' do
        output = builder.localized_fields do |localized_field|
          localized_field.text_area :title
        end

        expected =  %{<textarea id="post_title_translations_en" name="post[title_translations][en]">\ntitle en}
        expected << %{</textarea>}
        expected << %{<textarea id="post_title_translations_pt" name="post[title_translations][pt]">\ntitle pt}
        expected << %{</textarea>}

        expect(output).to eq(expected)
      end
    end
  end
end
