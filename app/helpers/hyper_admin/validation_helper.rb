# todo: create tests for everything in this file

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
end