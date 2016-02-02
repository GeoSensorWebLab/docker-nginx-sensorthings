# Nginx Forward Proxy for SensorThings

A [Docker](https://www.docker.com) image that can be used as an HTTP proxy to cache requests from a [SensorThings](http://ogc-iot.github.io/ogc-iot-api/) instance.

This image is configured to cache requests to http://chashuhotpot.sensorup.com/. HTTP requests with the status codes 200, 301, and 302 will be cached for 10 minutes. A disk cache at `/var/cache/nginx` will hold data for up to 1 day, or 100 megabytes.

This image is intended for developers doing heavy read-only work with SensorThings and who don't mind responses being slightly stale.

This image builds from the [nginx 1.9.10 Docker image](https://hub.docker.com/_/nginx/).

## How to Use This Image

### Running a Simple Proxy Cache

First clone the repo and build the Docker image:

    $ git clone https://github.com/geosensorweblab/docker-nginx-sensorthings
    $ cd docker-nginx-sensorthings
    $ docker build -t nginx-sensorthings:0.1 .

Then run the Docker container:

    $ docker run --detached --port 8080:8080 --name sensorthings-proxy nginx-sensorthings

Next configure your client or web browser to use the Docker host as it's HTTP proxy on port 8080. This will cause your HTTP requests to pass through this container, and any that have the HTTP Host header set to `chashuhotpot.sensorup.com` will be handled through the cache.

You can see requests coming into the log with Docker:

    $ docker logs -f nginx-sensorthings

### Enabling the Stub Status

This image has nginx with the stub_status module enabled on port 9080. This gives very basic status information on nginx.

    $ docker run --detached --port 8080:8080 --port 9080:9080 --name sensorthings-proxy nginx-sensorthings

### Editing the Cached Instance URL

This image by default only caches requests to http://chashuhotpot.sensorup.com/, all other requests are passed through. To change the host, edit `nginx.conf` and change the `server_name` directive to the hostname of the SensorThings instance.

## Supported Docker versions

This image is officially supported on Docker version 1.9.1.

Support for older versions (down to 1.6) is provided on a best-effort basis.

## User Feedback

### Issues

If you have any problems with or questions about this image, please use [GitHub Issues](https://github.com/GeoSensorWebLab/docker-nginx-sensorthings/issues).

### Contributing

You are invited to contribute new features, fixes, or updates, large or small; we are always thrilled to receive pull requests, and do our best to process them as fast as we can.

Before you start to code, we recommend discussing your plans through a [GitHub issue](https://github.com/GeoSensorWebLab/docker-nginx-sensorthings/issues), especially for more ambitious contributions. This gives other contributors a chance to point you in the right direction, give you feedback on your design, and help you find out if someone else is working on the same thing.

## License

This project is [MIT Licensed](http://opensource.org/licenses/MIT).
