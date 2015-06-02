# todo: rspec

module HyperAdmin
  module ValidationHelper

    # This Hash defines the mappings from Rails validations to their corresponding
	  # AngularJS directives and HTML attributes. It follows a unique but simple contract.
	  #
    # KEYS [Symbol] Identifiers of validations one would pass to the `validates` method
	  #   in an Active Record model file.
	  # VALUES [Array(String, Hash)] Array containing the identifier of equivalent AngularJS
	  #   validation directive, followed by an HTML attributes hash for its implementation.
	  #   Multiple directive identifiers may be specified by separating them with commas.
	  # VALUES [Proc] A lambda or Proc may be given instead, but it must evaluate to an
	  #   Array of the same format as previously described when called.
	  #
	  # Using a Proc allows for arbitrary transformation of the Rails validation data
	  #
    TRANSLATIONS = {
      presence: ['required', {required: true}],
      length: ->(v) {
	      # todo: implement support for :wrong_length, :too_long, and :too_short
	      # todo: implement support for %{count} placeholder
	      # todo: implement support for tokenizer
	      # todo: implement support for :only_integer
	      # todo: oh god when do these options end
        case
	        when v.options.key?(:minimum)
		        ['minlength', {'ng-minlength' => v.options[:minimum]}]
	        when v.options.key?(:maximum)
		        ['maxlength', {'ng-maxlength' => v.options[:maximum]}]
	        when v.options.key?(:in) || v.options.key?(:within)
		        range = v.options[:in] || v.options[:within]
		        ['minlength,maxlength', {'ng-minlength' => range.min, 'ng-maxlength' => range.max}]
	        when v.options.key?(:is)
		        ['minlength,maxlength', {'ng-minlength' => v.options[:is], 'ng-maxlength' => v.options[:is]}]
        end
      },
	    # todo: consider implementing support for :without option
      format: ->(v) { ['pattern', {pattern: v.options[:with].source}] }
    }

	  # This helper facilitates access to data in the TRANSLATIONS Hash, returning one or both of:
    #
	  # @return [Array<String>] Collection of one or more AngularJS validation directive names
	  # @return [Hash{Symbol, String => String}] Hash of HTML attributes representing AngularJS
    #   implementation of the validation (directives)
    def translate_rails_validation(validation, output = {})
	    angular_output = TRANSLATIONS[validation.kind]
	    resolved_data = angular_output.respond_to?(:call) ? angular_output.call(validation) : angular_output
	    case output
		    when {into: :angular_validations} then resolved_data.first.split(',')
		    when {into: :angular_directives}  then resolved_data.last
			  when {}                           then resolved_data
	    end
    end

  end

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

    # Generates `input` tag HTML for a `HyperAdmin::Resource` attribute, and is composed from:
    # - Pre-defined attributes representing an AngularJS form control for given attribute type
    # - Attributes defining AngularJS validations, translated from those declared in the Rails model
    # - Arbitrary attributes Hash passed to the helper
    def field_with_validations_for(attribute, options = {})
      field_type = infer_type_from_attribute attribute
      attr_hash = FORM_FIELD_ATTRIBUTES[field_type.to_sym]

      @resource._validators[attribute].each do |v|
        attr_hash.update translate_rails_validation(v, into: :angular_directives)
      end

      tag :input, options.merge(attr_hash)
    end

    # Returns a collection of all error messages for given `HyperAdmin::Resource` attribute,
    # based on the validations declared in the associated Rails model. The data is returned
    # as a Hash whose keys are AngularJS directives corresponding to the Rails validations.
    #
    # If no message is given,
    # a Hash of default error messages is checked to see if one exists for the attribute type.
    #
    # @param [Symbol] attribute Name of an attribute on an `ActiveRecord::Base` descendant
    def error_messages_for(attribute)
      if @resource._validators[attribute].empty?
	      # todo: should do testing to confirm this always produces valid directive names...
	      type = infer_type_from_attribute attribute
        {type => DEFAULT_ERROR_MESSAGES[type] || ''}
      else
	      # All validations with messages are collected, and converted one-by-one into corresponding
	      # AngularJS directives along with their messages. This type of iteration is necessary
	      # because some Rails validations result in multiple AngularJS directives being produced
	      # (:length, for example) but each attribute only has one message (for now).
        @resource._validators[attribute].keep_if { |v| v.options.key? :message }.inject({}) do |out, validation|
		      translate_rails_validation(validation, into: :angular_validations).each do |directive|
			      out[directive] = validation.options[:message]
		      end
	        out
	      end
      end
    end

    def infer_type_from_attribute(attr)
      @resource_class.columns_hash[attr.to_s].type
    end

  end
end