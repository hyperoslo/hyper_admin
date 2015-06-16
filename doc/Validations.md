# Client-side Rails validations
This file provides a summary and explanation of changes made in the [`feature/client-side-validations`][1] branch.

### Concept
Though Rails and AngularJS offer validation features whose capabilities are quite similar, they represent two disparate paradigms. Rails validations are designed entirely for use on the server, while AngularJS is of course a client-side framework (although it also possess server-side validation tools). This is an attempt to bring Rails validations over to the client-side. With this update, validations specified in Rails models are automagically brought to life via AngularJS HTML validations. 

### Supported validations
Only the most simple validations are implemented for this demo. They are listed in the table below, alongside corresponding AngularJS attributes, and whether or not supported by HTML5.                                                                                                                     

| ActiveRecord    | AngularJS      | HTML5 |
|-------------------|----------------|-------|
| `presence`        | `required`     | YES   |
| `length: minimum` | `ng-minlength` | YES   |
| `length: maximum` | `ng-maxlength` | YES   |
| `format`          | `pattern`      | YES   |


## Implementation
**Logic**

- The process of turning Rails validations into their AngularJS equivalents is very simple. Specific validation methods/options map to specific HTML attributes in a `1:1` relation. That is why I encapsulate them within a `Hash`. All but the simplest of validations will require *some* logic to translate, in which case I substitute a `Hash` literal for a `lambda` which returns the same. One of my favorite Ruby tools, the `lambda` is ideal for use when one needs to treat a procedure like data. See `HyperAdmin::ValidationHelper::TRANSLATIONS` in the file `app/helpers/hyper_admin/form_helpers.rb`.
- Validation data for a model can be programmatically accessed in several ways from a `HyperAdmin::Resource` type object, thanks to methods/accessors inherited from `ActiveRecord`.
- For instance, `#_validators` returns a collection of `ActiveRecord::Validations::{Type}Validator` objects, where `Type` is one of the validators supported by `ActiveRecord` such as `Presence` or `Length`.

**Presentation**

- Forms are produced dynamically on the client-side, using pre-rendered AngularJS templates. I realized that as a result, no object data is available to the templates unless specifically loaded into AngularJS beforehand. This is sufficient when the page requires little information about objects, but **for several reasons, I chose to redo the form templating code entirely, using an ERB-centric approach**.
- AngularJS validations are implemented with HTML attributes and/or content added to form inputs. Composition of such elements is best handled with a view helper, and Rails already provides helpers that generate tags from an attributes `Hash`, which we can build off of.
- In the partial `_form.html.erb`, I replaced the static AngularJS templates with ERB that generates a template for each field, instead of one template per field type. This is necessary because the inputs require data from the current `Resource` at render. It is also more DRY. This change does not affect AngularJS code or operation except that each template `id` is set to the attribute name, so in the `resourceForm` directive the `src` attribute of `ng-include` tag must be set to `'attr.key'`.


[1]: https://github.com/SteveBenner/hyper_admin/tree/feature/client-side-validations