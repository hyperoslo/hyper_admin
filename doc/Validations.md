# Client-side Rails validations
This provides a summary and explanation of changes made in `feature/client-side-validations`.

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

- Validation data for a model can be programmatically accessed in several ways from a `HyperAdmin::Resource` type object, thanks to methods/accessors inherited from `ActiveRecord`.
- For instance, `#_validators` returns a collection of `ActiveRecord::Validations::{Type}Validator` objects, where `Type` is one of the validators supported by `ActiveRecord` such as `Presence` or `Length`.
- My approach to the problem [of converting Rails validations into their AngularJS equivalent] was to imagine a function that takes validation data as input,  yields a `String` of specific HTML, which can be represented by an attributes `Hash`. Because specific inputs (e.g. `:presence`) map to specific outputs (e.g. `{presence: true}`) these translations can be captured within a single `Hash`. See `HyperAdmin::ValidationHelper::TRANSLATIONS` in the file `app/helpers/hyper_admin/form_helpers.rb`.
- Creating 'Translations' to properly capture Rails validations that are even *slightly* complex requires some logic. Enter Ruby's `lambda`, a tool that lets us treat code procedures like data. Methods accessing `TRANSLATIONS` expect a `Hash` of HTML attributes to be returned for a given key; a `lambda` might be provided in place of a literal `Hash`, as long as it doesn't break the signature/contract. In other words, we could use a `lambda` if it returns an HTML attributes `Hash`.

**Presentation**

- Forms are produced dynamically on the client-side, using pre-rendered AngularJS templates. I realized that as a result, no object data is available to the templates unless specifically loaded into AngularJS beforehand, which I noticed being done with JSON from jBuilder. This is sufficient when the page requires little information about objects, but **for several reasons, I chose to replace the form templating code entirely, using an ERB-centric approach**.
- Most significantly, the partial `_form.html.erb` generates AngularJS templates with `id` values corresponding to attributes of the current `Resource`, instead of one for each `type` of attribute. After all, each form input may contain unique HTML depending on what validations are specified for the related attribute. This change is compatible with all interface code; the only alteration needed is setting the `src` value to `'attr.key'` in the AngularJS `resourceForm` directive template.
- Implementing validations in AngularJS takes the form of HTML attributes and/or content being added to form elements, so the obvious solution is to construct the inputs using a helper. Rails already utilizes the technique of generating tags from an attributes `Hash`, as with `content_tag`.
- The code in `HyperAdmin::FormHelper` facilitates all the HTML generation for AngularJS validations.