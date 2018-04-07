# The Weekly Output

### Development Environment

Initial Setup:

```bash

> git clone git@github.com:TheWeeklyOutput/TWO.git TWO
> cd TWO/
> git submodule init
> git submodule update
> make dev

# install initial categories, outelts, etc.
> make fixtures

# crawl new articles
> make management "crawl --date 2018-02 --amount-per-category 10"

# generate new articles (if you dont do this when setting up, you wont be able to get any hightlights)
> make management "generate --active-categories True --amount 5"
```

Running:

```bash

> make run-dev

```

Misc. Commands:

```bash
# git
make commit
make push
make pull

# clean venv and dependencies
make clean

# backup database and make a new one
make new-db

# install dependencies
make dev

# migrate django
make migrate

# django management command
make mangement "<command>"
```
