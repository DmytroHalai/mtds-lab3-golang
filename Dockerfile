FROM golang:1.21-alpine AS builder

WORKDIR /app
COPY . .
RUN go mod tidy && go build -o fizzbuzz


FROM scratch

COPY --from=builder /app/fizzbuzz /fizzbuzz
COPY --from=builder /app/templates /templates

EXPOSE 8080

ENTRYPOINT ["/fizzbuzz"]
CMD ["serve", "--port=8080"]
