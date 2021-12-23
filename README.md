<h1 align="center">✏️ Story Toss ⚾</h1>

Welcome to the [Story Toss](https://storytoss.herokuapp.com/) codebase. I built this app as an exercise which [you can read all about on my blog](https://fpsvogel.com/posts/2021/pass-the-story-collaborative-writing). It served as a mini capstone project after I read Jason Swett's [Complete Guide to Rails Testing](https://www.codewithjason.com/complete-guide-to-rails-testing/).

### Table of Contents

- [Why this is on my GitHub portfolio](#why-this-is-on-my-github-portfolio)
- [Contributing](#contributing)
- [Requirements](#requirements)
- [Initial setup](#initial-setup)
- [License](#license)

## Why this is on my GitHub portfolio

In building this app, I followed a more test-centric development process than I had ever done before, at least in Rails.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/fpsvogel/storytoss.

## Requirements

- Ruby 3+
- Node.js 14+
- PostgreSQL 9.3+

## Initial setup

- Checkout the storytoss git tree from Github:
    ```sh
    $ git clone git://github.com/fpsvogel/storytoss.git
    $ cd storytoss
    storytoss$
    ```
- Run Bundler to install gems needed by the project:
    ```sh
    storytoss$ bundle
    ```
- If this is your first time using PostgreSQL, log in to PostgreSQL and create a user:
    ```
    $ psql -U postgres
    postgres=# create role "your_username" login createdb
    postgres=# exit
    ```
- Create the development and test databases:
    ```sh
    storytoss$ rails db:create
    ```
  - If you see an error about peer authentication, then you need to [change one or two settings in pg_hba.conf](https://stackoverflow.com/questions/18664074/getting-error-peer-authentication-failed-for-user-postgres-when-trying-to-ge), then try creating the databases again.
- Load the schema into the new database:
    ```sh
    storytoss$ rails db:schema:load
    ```
- Seed the database:
    ```sh
    storytoss$ rails db:seed
    ```

## License

Distributed under the [MIT License](https://opensource.org/licenses/MIT).
