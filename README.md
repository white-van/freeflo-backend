# README

Besides Ruby, Rails, and Bundler, make sure you have these:

1. PostgreSQL `brew install postgresql`
2. CockroachDB `brew install cockroachdb/tap/cockroach`
3. CockroachDB certificate (Discord)
4. Redis `brew install redis`

After cloning and setting up the repo, run

```
bundle install
```

Install Foreman (Not in Gemfile):

```
gem install foreman
```

Start the Rails server, Redis, and workers with:

```
foreman start
```

To launch CockroachDB SQL, run:

```
cockroach sql --url 'postgres://rails-backend@freeflow-main-7dmaws-us-east-1.cockroachlabscloud:26257/defaultdb?sslmode=verify-fullsslrootcert=< certs_directory >/freeflow-main-ca.crt'
```
