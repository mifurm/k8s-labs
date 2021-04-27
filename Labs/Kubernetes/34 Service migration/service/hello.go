package main

import (
	"encoding/json"
	"net"
	"net/http"
	"os"
)

var requestCount int = 0

type Response struct {
	Name string
	IP   string
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

func hello(w http.ResponseWriter, r *http.Request) {
	res := Response{name(), ip()}
	js, err := json.Marshal(res)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}
	w.Header().Set("Content-Type", "application/json")
	w.Write(js)
}

func main() {

	http.HandleFunc("/", hello)
	http.ListenAndServe(":8080", nil)
}
