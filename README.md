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

Knowledge Base is available under the MIT license.
