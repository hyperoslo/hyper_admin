# Client-side Rails validations
This file provides a summary and explanation of changes made in the [`feature/client-side-validations`][1] branch.

### Concept
Though Rails and AngularJS offer validation features whose capabilities are quite similar, they represent two disparate paradigms. Rails validations are designed entirely for use on the server, while AngularJS is of course a client-side framework (although it also possess server-side validation tools). This is an attempt to bring Rails validations over to the client-side. With this update, validations specified in Rails models are automagically brought to life via AngularJS HTML validations.

### Supported validations
Only the most simple validations are implemented for now. The table below describes options passed to the `validates` method in a Rails model, alongside the HTML attributes which represent corresponding AngularJS and HTML5 validation directives. Note that in some cases the HTML attribute is necessary to produce desired behavior, rather than the Angular-specific variant.                             

| ActiveRecord    | AngularJS      | HTML5 |
|-------------------|----------------|-------|
| `presence`        | `required`     | `required`   |
| `length: minimum` | `ng-minlength` | `minlength`   |
| `length: maximum` | `ng-maxlength` | `maxlength`   |
| `format`          | `pattern`      | `pattern`   |


## Implementation
**Logic**

- The process of turning `ActiveRecord` validations into their AngularJS equivalents is very simple. Each validation can be described by a `1:1` relation between a set of specific options passed to the `validates` method and 1-2 HTML attribute key/value pairs representing the AngularJS implementation (identified by a directive ID as shown in above table). The data and relations are simple enough to encapsulate within a single `Hash` (see [`HyperAdmin::ValidationHelper::TRANSLATIONS`][2]).
- Most validations require *some* logic to translate. To handle this, I turn to `lambda`, which lets one define a procedure and use it like data. `Proc`s can be used interchangeably with literal `Hash` values in `TRANSLATIONS`, as long as the contract is enforced so that `Proc.call` evaluates to a `Hash`. This allows for arbitrary transformation of Rails validation data without adding complexity to the code.
- Validation data for a model can be programmatically accessed in several ways from a `HyperAdmin::Resource` type object, thanks to methods/accessors inherited from `ActiveRecord`. For instance, `#_validators` returns a collection of `ActiveRecord::Validations::{Type}Validator` objects (where `Type` is one of the validators supported by `ActiveRecord` such as `Presence` or `Length`).

**Presentation**

- Forms are produced dynamically on the client-side, using pre-rendered AngularJS templates. I realized that as a result, no object data is available to the templates unless specifically loaded into AngularJS beforehand. This is sufficient when the page requires little information about objects, but **for several reasons, I chose to redo the form templating code entirely, using an ERB-centric approach**.
- AngularJS validations are implemented with HTML attributes and/or content added to form inputs. Composition of such elements is best handled with a view helper, and Rails already provides helpers that generate tags from an attributes `Hash`, which we can build off of.
- In the partial `_form.html.erb`, I replaced the static AngularJS templates with ERB that generates a template for each field, instead of one template per field type. This is necessary because the inputs require data from the current `Resource` at render. It is also more DRY. This change does not affect AngularJS code or operation except that each template `id` is set to the attribute name, so in the `resourceForm` directive the `src` attribute of `ng-include` tag must be set to `'attr.key'`.

## Example
Underneath the hood, the process of translating Rails validations to AngularJS output is fairly involved, even if it is simple in concept. Here is a step-by-step illustration of how it works:

**Take [the `Article` model from my demo app][3] for instance, examining the `length` validation.**

```ruby
validates :title, length: {minimum: 4, message: 'wtf too short'}
```

When a form is rendered, the an `input` HTML tag is generated for each field specified in [the HyperAdmin config file][4], using `HyperAdmin::FormHelper#field_with_validations_for`.

The controller, an instance of `HyperAdmin::ResourceController`, conveniently provides the variable `@resource`, which references the current `HyperAdmin::Resource` (in this case it is `Article`). Such objects are descended from `ActiveRecord::Base`, and therefore expose validation data via `_validators` method, which returns a `Hash`.

```ruby
@resource._validators[attribute].each do |v|
    attr_hash.update angularjs_html_for v
end
```

The `:title` attribute yields a collection of several validators; the one relevant in this case is an instance of `ActiveModel::Validations::LengthValidator`, which is passed to the `angularjs_html_for` helper as `v`.

In the first line, the object is handed off to `translate_rails_validation` helper.

```ruby
validation_data = translate_rails_validation validation
```

At this point `HyperAdmin::ValidationHelper::TRANSLATIONS` is accessed, using the value returned from `ActiveModel::Validator::kind`, namely `:length`, as a key.

```ruby
result = TRANSLATIONS[validation.kind]
```

The result is a `Proc` that will produce a different result based on the options passed to `validates` in the model file. This data, `{:minimum=>4, :message=>"wtf too short"}`, is available via `options` attribute of the validation object, which is passed to the `Proc` as parameter `v`.

```ruby
length: ->(v) {                                                                                    
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
}                                                                      
```

The `Proc` is evaluated, returning `{minlength: {'ng-minlength' => 4}` to the `angularjs_html_for` helper, where it is converted in to a `Hash` of HTML attributes which can be used in Rails tag generators. 

```ruby
Hash[*validation_data.values.map(&:to_a).flatten] 
```

Helper `field_with_validations_for` calls `ActionView::Helpers::TagHelper#tag` to produce an `input` tag which contains (among other attributes):

```html
ng-minlength="4"
```

The `<ng-message>` elements are produced in essentially the same manner, by iterating over the return value of `HyperAdmin::FormHelper#errors_with_messages_for`. This helper utilizes `HyperAdmin::ValidationHelper::angularjs_errors_for` to pair AngularJS errors with the messages defined in the Rails model file:

```ruby
@resource._validators[attribute].keep_if { |v| v.options.key? :message }.inject({}) do |h, validation|
  angularjs_errors_for(validation).each do |directive|                                                
    h[directive] = validation.options[:message]                                                       
  end                                                                                                 
  h                                                                                                   
end                                                                                                   
```

The output of `{'ng-minlength' => 'wtf too short'}` will render to

```html
<ng-message when="ng-minlength">wtf too short</ng-message>
```

You can see the end result in action by downloading and running [my demo app][5].


[1]: https://github.com/SteveBenner/hyper_admin/tree/feature/client-side-validations
[2]: app/helpers/hyper_admin/validation_helper.rb
[3]: https://github.com/SteveBenner/hyper-admin-app-demo/blob/master/app/models/article.rb#L4]
[4]: https://github.com/SteveBenner/hyper-admin-app-demo/blob/master/app/admin/article.rb
[5]: https://github.com/SteveBenner/hyper-admin-app-demo/