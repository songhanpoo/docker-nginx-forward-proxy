## Run Locally

Clone the project

```bash
  git clone https://github.com/songhanpoo/docker-nginx-forward-proxy
```

Go to the project directory

```bash
  cd docker-nginx-forward-proxy
```

Testing Locally

```bash
  docker compose up --force-recreate --no-deps --build proxy
```

Testing by curl

```bash
  curl -u songhanpoo -x http://127.0.0.1:3128 http://google.com
```

## License

[MIT](https://choosealicense.com/licenses/mit/)

## Authors

- [@Songhanpoo](https://www.github.com/songhanpoo) - Forked
- [@Wiscaksono](https://www.github.com/wiscaksono) - Owner
- [@Yanka Darelova](https://www.behance.net/darelova) - Designer
