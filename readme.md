Use Docker to get a MySQL server running.

Pull the image:

```
docker pull mysql:8.0
```

Make a directory named `'data/'` at the root of your checkout of this repo.

Create a Docker network:

```
docker network create aniblog-net
```

Run the container:

```
docker run --name aniblog-mysql \
  --restart unless-stopped \
  --network=aniblog-net \
  -v ./data:/var/lib/mysql \
  -e MYSQL_DATABASE=rss_aggregator \
  -e MYSQL_ROOT_PASSWORD=root_password \
  -e MYSQL_USER=aniblog \
  -e MYSQL_PASSWORD=another_password \
  -p 3306:3306 \
  -d mysql:8.0
```
