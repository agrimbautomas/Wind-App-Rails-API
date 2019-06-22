# wind-api - WS

This is a Ruby on Rails application.

## Requirements

- _Ruby_ > 2.5.1
- _Rails_ > 5.1.6
- _Postgres_ > 9.6.4
- _Docker_ > 18.03.1
- _Docker Compose_ > 1.21.1

## Badges

> Production
[![pipeline status](https://gitlab.com/agrimbautomas/wind-api/badges/production/pipeline.svg)](https://gitlab.com/agrimbautomas/wind-api/commits/production)
[![coverage report](https://gitlab.com/agrimbautomas/wind-api/badges/production/coverage.svg)](https://gitlab.com/agrimbautomas/wind-api/commits/production)
## Docker

The project is Docker-ready. To start developing we just need to have Docker installed.

```sh
cp config/database.yml.example config/database.yml
cp config/secrets.yml.example config/secrets.yml
cp config/settings/example.yml config/settings/development.yml
cp .env.dev .env
cp Dockerfile.dev Dockerfile
docker-compose build && docker-compose run wind-api_ws bundle
docker-compose run wind-api_ws rake db:create db:migrate db:seed
docker-compose up -d && docker attach wind-api_ws
```

And that's it :-)


## Deploy

Only need run the next command:

```sh
docker-compose run app bundle exec cap [ENVIRONMENT] deploy
```

Possible Environments: `development`, `staging` and `production`

## Reports

The rake task *app:reports* is used to generate all of the following reports.

### Tests

[RSpec][1] and [RSpec-Rails][2] are used for testing, following [Test-Driven Development][3] methodologies.
To run the tests use *spec* rake task or *app:test*.

```sh
bundle exec spec
```

or

```sh
bundle exec app:test
```

### Code Coverage

[SimpleCov][4] is used for code coverage reports. To generate a coverage report from tests use the rake task *app:coverage*.

```sh
bundle exec rake app:coverage
```

The report is saved at `reports/coverage/index.html`.

### Code Review

Automatic code review is implemented using [Rubycritic][6] and [Rubocop][7]. Rubycritic is used for code smells, and Rubocop
for style conventions and other syntax issues.

- Rubycritic is run with *app:codereview*.
- Rubocop is run using *app:lint*.

```sh
bundle exec rake app:codereview
bundle exec rake app:lint
```

- Rubycritic output is saved at `reports/codereview/overview.html`.
- Rubocop output is saved at `reports/lint.html`.

The rake task *app:lint:auto_corret* tries to auto correct errors detected by Rubocop.

## Rake Tasks

- *app:lint*: Code style and syntax issues report generator (report task).
- *app:lint:auto_correct*: Auto-correct Lint issues.
- *app:codereview*: Automatic code-review report (report task).
- *app:test* or *spec*: Run all tests in spec directory.
- *app:coverage*: Generate code coverage report from tests (report task).
- *app:reports*: Run all the report generation tasks (report task).

## API

### Documentation

[RAML][8] is used to generate API documentation from RAML spec files. Main RAML file is at [/docs/api/main.raml][9].

Use [RAML Console][10] or [RAML to HTML][11] to explore the documentation and test the API.

[1]: http://rspec.info/
[2]: https://github.com/rspec/rspec-rails
[3]: http://agiledata.org/essays/tdd.html
[4]: https://github.com/colszowka/simplecov
[5]: http://yardoc.org/
[6]: https://github.com/whitesmith/rubycritic
[7]: https://github.com/bbatsov/rubocop
[8]: http://raml.org/
[9]: /docs/api/main.raml
[10]: https://github.com/mulesoft/api-console
[11]: https://github.com/kevinrenskers/raml2html
