Use Docker to get a MySQL server running.

Pull the image:

```
docker pull mysql:8.1
```

Make a directory named `'data/'` at the root of your checkout of this repo.

Run the container:

```
docker run --name aniblog-mysql \
  --restart unless-stopped \
  -v ./data:/var/lib/mysql \
  -e MYSQL_DATABASE=rss_aggregator \
  -e MYSQL_ROOT_PASSWORD=root_password \
  -e MYSQL_USER=aniblog \
  -e MYSQL_PASSWORD=another_password \
  -p 3306:3306 \
  -d mysql:8.0
```
