<h1 align="center">✏️ Story Toss ⚾</h1>

Welcome to the Story Toss codebase. I built this app as a capstone project after I read Jason Swett's [Complete Guide to Rails Testing](https://www.codewithjason.com/complete-guide-to-rails-testing/). You can [read all about it on my blog](https://fpsvogel.com/posts/2021/pass-the-story-collaborative-writing-game).

### Table of Contents

- [Why this is on my GitHub portfolio](#why-this-is-on-my-github-portfolio)
- [Contributing](#contributing)
- [Requirements](#requirements)
- [Initial setup](#initial-setup)
- [License](#license)

## Why this is on my GitHub portfolio

In building this app, I followed a more test-centric development process than I had ever done before, at least in Rails.

Here are the testing rules of thumb that I set for myself at the beginning of this project:

1. When I add a feature, write tests for it before working on anything else.
2. Don't commit before writing tests or making sure the change is covered by existing tests. I made exceptions to this rule at the beginning and end of the project, when I was working mostly in the views and it didn't make sense to write system specs until after several interrelated features were finished.
3. When I'm building a model, use TDD as much as possible.

By the end of the project, these rules felt less like rules and more like just plain writing code. I didn't have to remind myself as often to write tests before committing, because the habit of testing had become a more seamless part my development process. And the more I did it, the more grateful I was that I'd done so: more than once an obscure bug came up that I found within just a few minutes, thanks to my tests. I shudder to think of the hours it might otherwise have taken me to track down those bugs.

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
