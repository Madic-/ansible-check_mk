# Misc

This folder contains obsolete files that, at this point, I don't want to delete.

## Tests

It's possible to test the role against a docker container. The provided test script must be run from the root of the role. By providing environment variables you can slightly modify the behaviour of the script.

    DISTRO=debian9 ./tests/test.sh
    APT_CACHER_ENABLED=true APT_CACHER_URL=http://10.59.100.229:3142/ CLEANUP=false ./tests/test.sh

The following environment variables are availables:

| Variable           | Values                     | Usage                                                         |
| ------------------ | -------------------------- | ------------------------------------------------------------- |
| APT_CACHER_ENABLED | true<br>**false**          | Enable apt-cacher-ng usage                                    |
| APT_CACHER_URL     | http://apt-cacher-ng:3142/ | URL to the apt-cacher-ng proxy                                |
| CLEANUP            | **true**<br>false          | Should the docker container at the end be stopped and removed |
| DISTRO             | **ubuntu1804**<br>debian9  | Distribution to test against                                  |
