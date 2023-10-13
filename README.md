# TheWhere

This is another way of querying in Ruby.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'the_where'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install the_where

## Usage

## TheWhere

This Library set default params process for where query in ActiveRecord

## Features and Usage

### Normal equal params

- Params:

```ruby
# rails 4 and later, the_where does nothing
params = { role_id: 1, age: 20 }
User.the_where(params)
```

### Equal params with association

- params
```ruby
User.belongs_to :role
params = { name: 'dhh', 'role.id': 2 }

# you can use any table name or reference name
params = { name: 'dhh', 'roles.id': 2 }
```
- Before use `the_where`
```ruby
User.includes(:student).where(name: params[:name], role: {id: params[:'role.id']})
```
- After Use `the_where`
```ruby
User.the_where(params)
```

### Range params
- params
```ruby
params = { 'role_id-lte': 2 }
```
- Before use `the_where`
```ruby
User.where('role_id >= ?', params[:'role_id-lte'])
```
- After use `the_where`
```ruby
User.the_where(params)
```

### Auto remove blank params by default, no need write query with `if else`
- params
```ruby
params = { age: '', role_id: 1 }
```

- Before use `the_where`
```ruby
users = User.where(role_id: params[:role_id])
users = users.where(age: params[:age]) if params[:age]
```
- After use `the_where`
```ruby
User.the_where(params)

# also can control which blank value can use
User.the_where(params, { allow: [nil] })
```

### Order params
- Params
```ruby
params = { 'age-asc': '1', 'last_login_at-asc': '2' }
```
- Before use `the_where`
```ruby
User.order(age: :asc, last_login_at: :asc)
```
- After use `the_where`
```ruby
User.the_where(params)
```

## A sample with all params above
- Params
```ruby
{ name: 'dhh', 'role.id': 2, 'age-lte': 2, 'age-asc': '1', 'last_login_at-asc': '2' }
```
- Before use `the_where`
```ruby
User.includes(:role).where(name: params[:name], 'roles.id': params[:'role.id']).order(age: :asc, last_login_at: :asc)
```
- After use `the_where`
```ruby
User.the_where(params)
```


## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/gith-u-b/the_where. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/the_where/blob/master/CODE_OF_CONDUCT.md).


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the TheWhere project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/the_where/blob/master/CODE_OF_CONDUCT.md).
