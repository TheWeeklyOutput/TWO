# The Weekly Output

### Development Environment

Initial Setup:

```bash

> git clone git@github.com:TheWeeklyOutput/TWO.git TWO
> cd TWO/
> git submodule init
> git submodule update
> make dev

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

