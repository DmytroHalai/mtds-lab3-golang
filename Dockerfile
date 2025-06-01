FROM golang:1.21-alpine AS builder

RUN apk add --no-cache git

WORKDIR /app

COPY . .

RUN go mod tidy

RUN go build -o fizzbuzz

FROM alpine:latest

RUN apk add --no-cache ca-certificates

WORKDIR /root/

COPY --from=builder /app/fizzbuzz .
COPY --from=builder /app/templates ./templates

EXPOSE 8080

CMD ["./fizzbuzz", "serve", "--port=8080"]
