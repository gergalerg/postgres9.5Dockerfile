To create a working Postgres9.5 Docker image
from an Ubuntu:xenial image base image.

All the docs on the web say use 'wget'. 

The thing is, wget is no longer included by default in 
Ubuntu 16.04 (Xenial)

You have to install it and then run wget.....


To make the image you run:

`docker build -t postgres9.5 .`

and then to test it you can create a container:

`docker run --rm -P --name pg_test postgresql9.5`


