Docker Hub: iamfat/cnpmjs
===========

## cnpmjs Repo Server
```bash
docker build -t iamfat/cnpmjs cnpmjs

export BASE_DIR=/docker/cnpmjs

docker run --name cnpmjs-mysql -v /dev/log:/dev/log --privileged \
    -v $BASE_DIR/logs/supervisor:/var/log/supervisor \
    -v $BASE_DIR/logs/mysql:/var/log/mysql \
    -d iamfat/mysql

docker run --name cnpmjs-redis -v /dev/log:/dev/log --privileged \
    -v $BASE_DIR/logs/supervisor:/var/log/supervisor \
    -v $BASE_DIR/logs/redis:/var/log/redis \
    -d iamfat/redis

docker run --name cnpmjs -v /dev/log:/dev/log --privileged \
    -v $BASE_DIR/logs/supervisor:/var/log/supervisor \
    -v $BASE_DIR/logs/cnpmjs:/var/log/cnpmjs \
    --link cnpmjs-mysql:mysql \
    --link cnpmjs-redis:redis \
    -p 7001:7001 \
    -p 7002:7002 \
    -d iamfat/cnpmjs
```

