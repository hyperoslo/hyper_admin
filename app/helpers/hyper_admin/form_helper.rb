# todo: rspec

module HyperAdmin
  module ValidationHelper
    # The keys of this Hash are Symbols identifying a type of Rails validation.
    # Values may be either a literal Hash or a lambda which returns a Hash. The Hash
    # contains HTML attributes (including :content) and keys may be either String or Symbol.
    TRANSLATIONS = {
      presence: {required: true},
      length: ->(v) {
        h = {}
        h['ng-minlength'] = v.options[:minimum] if v.options[:minimum]
        h['ng-maxlength'] = v.options[:maximum] if v.options[:maximum]
        h
      },
      format: ->(v) { {pattern: v.options[:with].source} }
    }
  end

  module FormHelper
    # This data is used by view helpers to generate the HTML comprising form elements
    BASE_ATTRIBUTES = {
      class:       'form-control',
      name:        '{{ attr.key }}',
      placeholder: '{{ attr.placeholder }}',
      ng_model:    'formController.resource[attr.key]'
    }
    FORM_FIELD_ATTRIBUTES = Hash[{
      date:     {type: 'date'},
      datetime: {type: 'datetime-local'},
      email:    {type: 'email'},
      integer:  {type: 'number'},
      string:   {type: 'text'},
      text:     {},
      url:      {type: 'url'}
    }.collect { |field_name, attrs| [field_name, BASE_ATTRIBUTES.merge(attrs)] }]
    DEFAULT_ERROR_MESSAGES = {
      date:     'Please input a date in the format <em>yyyy</em>-<em>mm</em>-<em>dd</em>',
      datetime: 'Please input a date and time in the form in the format <em>yyyy</em>-<em>mm</em>-<em>dd</em>T<em>hh</em>:<em>mm</em>:<em>ss</em>',
      email:    'Please input a valid e-mail address',
      integer:  'Please input a valid number',
      url:      'Please input a valid URL'
    }

    # NOTE: The following methods assume the context is an instance of `HyperAdmin::ResourceController`

    # Generates `input` tag HTML for a `HyperAdmin::Resource` attribute, and is composed from:
    # - Pre-defined attributes representing an AngularJS form control for given attribute type
    # - Attributes defining AngularJS validations, translated from those declared in the Rails model
    # - Arbitrary attributes Hash passed to the helper
    def field_with_validations_for(attribute, options = {})
      field_type = infer_type_from_attribute attribute
      attr_hash = FORM_FIELD_ATTRIBUTES[field_type.to_sym]

      @resource._validators[attribute].each do |validation|
        output = HyperAdmin::ValidationHelper::TRANSLATIONS[validation.kind]
        attr_hash.update(output.respond_to?(:call) ? output.call(validation) : output)
      end

      tag :input, options.merge(attr_hash)
    end

    # Returns the error message for a given `HyperAdmin::Resource` attribute as declared in
    # the associated Rails model via the `message` validation option. If no message is given,
    # a Hash of default error messages is checked to see if one exists for the attribute type.
    def error_message_for(attribute)
      if @resource._validators[attribute].empty?
        DEFAULT_ERROR_MESSAGES[infer_type_from_attribute attribute] || ''
      else
        @resource._validators[attribute].first.options[:message]
      end
    end

    def infer_type_from_attribute(attr)
      @resource_class.columns_hash[attr.to_s].type
    end
  end
end