package main

import (
	"encoding/json"
	"fmt"
	"net"
	"os"

	"github.com/aws/aws-lambda-go/events"
	"github.com/aws/aws-lambda-go/lambda"
)

type Response struct {
	Name string
	IP   string
}

func handler(request events.APIGatewayProxyRequest) (events.APIGatewayProxyResponse, error) {
	res := Response{name(), ip()}
	js, err := json.Marshal(res)
	if err != nil {
		return events.APIGatewayProxyResponse{}, err
	}
	return events.APIGatewayProxyResponse{
		Body:       fmt.Sprintf(string(js)),
		StatusCode: 200,
	}, nil
}

func main() {
	lambda.Start(handler)
}

func name() string {
	name, err := os.Hostname()
	if err != nil {
		return ""
	}
	return name
}

func ip() string {
	addrs, err := net.InterfaceAddrs()
	if err != nil {
		return ""
	}
	for _, address := range addrs {
		if ipnet, ok := address.(*net.IPNet); ok && !ipnet.IP.IsLoopback() {
			if ipnet.IP.To4() != nil {
				return ipnet.IP.String()
			}
		}
	}
	return ""
}
