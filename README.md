# The Weekly Output

### Development Environment

Initial Setup:

```bash

> git clone git@github.com:TheWeeklyOutput/TWO.git TWO
> cd TWO/
> git submodule init
> git submodule update
> make dev
> make fixtures
> make management "crawl --date 2018-02 --amount-per-category 10"
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
make new-dbs

# install dependencies
make dev

# migrate django
make migrate

# django management command
make mangement "<command>"
```