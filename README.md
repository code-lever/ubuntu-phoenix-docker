# Ubuntu Phoenix Docker base image

An Ubuntu-based Docker base image for Elixir and Phoenix applications.

See: https://hub.docker.com/r/codelever/ubuntu-phoenix-docker

## Making a release

1. Make relevant changes to the `Dockerfile`
1. Build image
    ```bash
    docker build .
    ```
1. Test it out
    ```bash
    docker run -it {IMAGE_ID} bash
    root@xxxxx:/# erl / iex / node / npm
1. Tag image
    ```bash
    docker tag {IMAGE_ID} codelever/ubuntu-phoenix-docker:ubuntu-{VERSION}-erlang-{VERSION}-elixir-{VERSION}-node-{VERSION}
1. Push to repository
    ```bash
    docker push codelever/ubuntu-phoenix-docker
    ```
