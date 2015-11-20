# todo: create tests for everything in this file

module HyperAdmin
  module FormHelper
    include ValidationHelper

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

    # Generates {input} tag HTML for a {HyperAdmin::Resource} attribute, and is composed from:
    # - Pre-defined attributes representing an AngularJS form control for given attribute type
    # - Attributes defining AngularJS validations, translated from those declared in the Rails model
    # - Arbitrary attributes Hash passed to the helper
    def field_with_validations_for(attribute, options = {})
      field_type = infer_type_from_attribute attribute
      attr_hash = FORM_FIELD_ATTRIBUTES[field_type.to_sym]

      @resource._validators[attribute].each do |v|
        attr_hash.update angularjs_html_for v
      end

      tag :input, options.merge(attr_hash)
    end

    # @param attribute [Symbol] Name of a {HyperAdmin::Resource} attribute in an {ActiveRecord} model
    # @return [Hash{Symbol=>String}] Collection of error data representing all validations for given
    #   attribute which have a message specified in the Rails model, as:
    #
    #   KEY: an AngularJS validator identifier representing a key on some {ngModel.$error} object
    #   VALUE: message to display when validation is in error state (normally hidden)
    #
    def errors_with_messages_for(attribute)
      # If an attribute has NO validations, then it is assigned a default error message
      # from {DEFAULT_ERROR_MESSAGES} for corresponding input field, if one exists.
      if @resource._validators[attribute].empty?
        # todo: add tests to confirm this always produces valid error identifier...
        type = infer_type_from_attribute attribute
        {type => DEFAULT_ERROR_MESSAGES[type] || ''}
      else
        # Some validations (such as :length) may correspond to multiple AngularJS directives,
        # so the error message must be assigned to each error returned from {TRANSLATIONS}.
        @resource._validators[attribute].keep_if { |v| v.options.key? :message }.inject({}) do |h, validation|
          angularjs_errors_for(validation).each do |directive|
            h[directive] = validation.options[:message]
          end
          h
        end
      end
    end

    def infer_type_from_attribute(attr)
      @resource_class.columns_hash[attr.to_s].type
    end

  end
end