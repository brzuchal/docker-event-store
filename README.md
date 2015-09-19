docker-event-store
==================

Ready to use docker container for [EventStore](http://geteventstore.com/)

## Building a container

Clone the repository, enter the directory, then build the image. By default version
3.0.5 of the [EventStore repository] is used for the build:

```bash
$ git clone https://github.com/mbrzuchalski/docker-event-store.git
$ cd docker-event-store
$ docker build -t event-store .
```

## Running

After you've built the container you can use it like this:

```bash
$ docker run -it event-store
```

## Running with docker-compose

Use `docker-compose` to run event-store with your app is simply. Just add it to your `docker-compose.yml`:

```yml
event-store:
  build: .
  extra_hosts:
   - "eventstore.com:127.0.0.1"
  volumes:
   - ./storage/db:/data/db
   - ./storage/log:/data/log
  ports:
    - "2113:2113"
    - "1113:1113"
```

If you build already an image you can use `image: event-store` instead of `build` param.
Then just run:

```bash
$ docker-compose up
```

And find your running EventStore in running containers:

```bash
$ docker-compose ps
```

Now find the ip address of the running event store:

```bash
$ docker inspect -f '{{ .NetworkSettings.IPAddress }}' $(docker ps -lq)
```

Visit `http://[your_ip_address]:2113` for the web ui!

## Thanks to

The Dockerfile in this repository is based on the:

* [dgafka](https://github.com/dgafka/event-sourcing-php)
* [pjvds](https://github.com/pjvds/Dockerfiles)

