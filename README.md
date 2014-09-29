# HyperAdmin

HyperAdmin is an admin interface solution for Ruby on Rails. It works pretty
much as a mountable engine, except it always mounts under _/admin_. This is
currently not configurable.

## Installation

Simply put the gem in your Rails application's Gemfile:

```ruby
gem 'hyper_admin'
```

Then, install the bundle as usual:

```
$ bundle install
```

Finally, mount HyperAdmin into your application. Put this in your
_config/routes.rb_ file:

```ruby
HyperAdmin.routes self
mount HyperAdmin::Engine, at: '/admin'
```

As mentioned above, you must mount it under _/admin_ for the time being. In a
later version, this will be configurable.

## Usage

To register models that should be accessible through the admin, all you need to
do is register them with a single line of code. Do this in any Ruby file(s) you
want under _app/admin/_, such as _app/admin/article.rb_ or
_app/admin/person.rb_. When the application boots, HyperAdmin will check each
file under the _app/admin/_. To register a resource:

```ruby
HyperAdmin.register NameOfYourResource
```

For instance:

```ruby
HyperAdmin.register Article
```

With this in place, you can now visit _/admin/articles_ in your application and
start managing your articles.

### Configuring views

When registering resources, it is also possible to customize what fields should
show up where and (to some degree) how they should be displayed. For instance,
we might want to only show the ID, title and publication date of an article in
the index view. For that, we would pass in a block to `register` and specify
which columns to display on the index view, like this:

```ruby
HyperAdmin.register Article do
  index do
    column :id
    column :title
    column :published_at
  end
end
```

Note that the order matters here, so this could also be used to force an order
of attributes to be displayed. In the example above, HyperAdmin would know the
types of the attributes because of how it is registered in the database.
However, some types cannot be determined from the database alone. URL fields and
e-mail fields, for instance, are stored as text, so they will be treated as text
by default. It is possible to tell HyperAdmin what type of field you're
specifying by using the `type` keyword:

```ruby
HyperAdmin.register Article do
  index do
    column :id
    column :title
    column :published_at
    column :author_email, type: :email
  end
end
```

The **email** type will create a “mailto”-style link in the index and show
views, and an `<input type="email">` in the form. Likewise, the “url” type will
create a regular link in index/show and an `<input type="url">` in forms.

Lastly, it is also possible to customize the labeling of the attributes in each
view using the `human` keyword:

```ruby
HyperAdmin.register Article do
  index do
    column :id
    column :title
    column :published_at, human: "Publication date"
    column :author_email, type: :email
  end
end
```

Note that if `human` is not specified, HyperAdmin will fetch the attribute name
from the currently active locale, which is recommended most of the time. `human`
is available for special cases where you want a label other than the localized
name of the attribute.

Customizing the show and form pages work the same way as the index pages, but
using the `row` and `field` methods instead, respectively. A fully customized
resource registration might look something like this:

```ruby
HyperAdmin.register Article do
  index do
    column :id
    column :title
    column :published_at, human: "Publication date"
  end

  show do
    row :id, human: "Article ID"
    row :title
    row :body
    row :published_at, human: "Publication date"

    column :author_email, type: :email
  end

  form do
    field :title
    field :body
    field :published_at
    field :author_email, type: :email
  end
end
```

## Contributing

1. Fork it
2. Check out the develop branch (`git checkout develop`)
3. Create your feature branch (`git checkout -b feature/my-new-feature`)
4. Commit your changes (`git commit -am 'Add my new feature'`)
5. Push to the branch (`git push origin my-new-feature`)
6. Create a new Pull Request

## Credits

Hyper made this. We're a digital communications agency with a passion for good
code, and if you're using HyperAdmin we probably want to hire you.

## License

HyperAdmin is available under the MIT license. See LICENSE.md for more details.
