FROM golang:1 AS build
WORKDIR /go/src/app
COPY . .
RUN go mod download
RUN CGO_ENABLED=0 go build -o /go/bin/app

FROM gcr.io/distroless/static-debian12
COPY --from=build /go/bin/app /
EXPOSE 8081
ENTRYPOINT ["/app", "--bind=0.0.0.0", "--listen=8081"]
