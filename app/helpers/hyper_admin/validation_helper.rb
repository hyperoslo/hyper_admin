# todo: create tests for everything in this file

module HyperAdmin
  module ValidationHelper

    # This Hash defines the mappings from Rails validations to their corresponding
    # AngularJS directives and HTML attributes. It follows a unique but simple contract.
    #
    # KEY: [Symbol] Identifier of a Rails validation as one would pass to the {#validates}
    #   method in an {ActiveRecord} model file.
    # VALUE: [Hash{Symbol=>Hash}] The AngularJS data necessary to implement the Rails
    #   validation specified by the key. Each 'translation' contains:
    #
    #   KEY: identifier of an AngularJS validation directive (see {ngModel.ngModelController})
    #   VALUE: {Hash} of HTML attributes representing the AngularJS validation implementation
    #
    # VALUE [Proc] A lambda or Proc may be provided, as long as it evaluates, when called,
    #   to a {Hash} of the exactly same format as described above.
    #
    TRANSLATIONS = {
      presence: {required: {required: true}},
      length: ->(v) {
        # todo: implement support for :wrong_length, :too_long, and :too_short
        # todo: implement support for %{count} placeholder
        # todo: implement support for tokenizer
        # todo: implement support for :only_integer
        # todo: oh god when do these options end
        case
          when v.options.key?(:minimum)
            {minlength: {'ng-minlength' => v.options[:minimum]}}
          when v.options.key?(:maximum)
            {maxlength: {'ng-maxlength' => v.options[:maximum]}}
          when v.options.key?(:in) || v.options.key?(:within)
            range = v.options[:in] || v.options[:within]
            {
              minlength: {'ng-minlength' => range.min},
              maxlength: {'ng-maxlength' => range.max}
            }
          when v.options.key?(:is)
            {
              minlength: {'ng-minlength' => v.options[:is]},
              maxlength: {'ng-maxlength' => v.options[:is]}
            }
        end
      },
      # todo: consider implementing support for :without option
      format: ->(v) { {pattern: {pattern: v.options[:with].source}} }
    }

    # The following helpers facilitate access to data in the TRANSLATIONS Hash

    # @param [#options] Validator object representing a single {ActiveRecord} validation
    # @return [Hash] The HTML attribute key/value pairs of all AngularJS directives
    #   corresponding to the given Rails validation, merged into a single {Hash}
    def angularjs_html_for(validation)
      validation_data = translate_rails_validation validation
      Hash[*validation_data.values.map(&:to_a).flatten]
    end

    # @param [#options] Validator object representing a single {ActiveRecord} validation
    # @return [Array<String>] List of identifiers for equivalent AngularJS validation errors
    def angularjs_errors_for(validation)
      validation_data = translate_rails_validation validation
      validation_data.keys
    end

    # @param [#options] Validator object representing a single {ActiveRecord} validation
    # @return [Hash{Symbol,String=>Hash}] Collection of equivalent AngularJS validations as:
    #
    #   KEY: an AngularJS validator identifier representing a key on some {ngModel.$error} object
    #   VALUE: {Hash} of HTML attributes representing the AngularJS validation implementation
    #
    def translate_rails_validation(validation)
      result = TRANSLATIONS[validation.kind]
      result.respond_to?(:call) ? result.call(validation) : result
    end

  end
end