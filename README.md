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

### OAuth
- `MICROSOFT_CLIENT_ID`
- `MICROSOFT_CLIENT_SECRET`
- `GOOGLE_CLIENT_ID`
- `GOOGLE_CLIENT_SECRET`

### AWS S3 *
- `AWS_ACCESS_KEY_ID`
- `AWS_SECRET_ACCESS_KEY`
- `AWS_REGION`
- `AWS_S3_BUCKET`