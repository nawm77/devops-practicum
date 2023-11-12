ARG GOARCH=amd64
FROM golang:1.21 as builder
WORKDIR /go/src/catgpt
COPY . .
RUN go mod download
RUN CGO_ENABLED=0 GOARCH=${GOARCH} go build -o /go/bin/catgpt

FROM alpine
COPY --from=builder /go/bin/catgpt .
CMD ./catgpt