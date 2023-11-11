FROM golang:1.21 as builder
WORKDIR /build
COPY . .
RUN go build -o app

FROM alpine
COPY --from=builder /build/app .
CMD ./app