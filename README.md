# Communote

## Initialization 
```
docker-compose up
docker-compose run web mix ecto.create
docker-compose run web mix ecto.migrate
```

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Environment variables
Create a `.env` file at the root of the project containing values for those fields. Fields with `*` are mandatory.

### AWS S3 *
- `AWS_ACCESS_KEY_ID`
- `AWS_SECRET_ACCESS_KEY`
- `AWS_REGION`
- `AWS_S3_BUCKET`