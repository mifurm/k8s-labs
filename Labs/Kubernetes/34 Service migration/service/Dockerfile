FROM golang:1.14.2-alpine AS build

COPY hello.go ./
RUN CGO_ENABLED=0 go build -o /bin/hello

FROM scratch
COPY --from=build /bin/hello /bin/hello

EXPOSE 8080

CMD ["/bin/hello"]