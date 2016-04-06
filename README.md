# Deploy

## Setup config for production

``` shell
$ cp .env.sample .env
```

Edit `.env` file.

```
GEMINABOX_SERVER_IP="YOUR-SERVER-IP"
GEMINABOX_USER_NAME="YOUR-SSH-USER-NAME"
```

## Deploy

``` shell
$ bundle exec cap staging deploy
$ bundle exec cap staging puma:config
$ bundle exec cap staging deploy
```
