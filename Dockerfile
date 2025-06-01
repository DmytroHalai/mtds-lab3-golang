FROM golang:1.21-alpine AS builder

WORKDIR /app

COPY . .
RUN go mod tidy && \
    CGO_ENABLED=0 GOOS=linux go build -o fizzbuzz

FROM gcr.io/distroless/static:nonroot

COPY --from=builder /app/fizzbuzz /fizzbuzz
COPY --from=builder /app/templates /templates

EXPOSE 8080
USER nonroot
ENTRYPOINT ["/fizzbuzz"]
CMD ["serve", "--port=8080"]
