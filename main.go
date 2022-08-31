package main

import (
	"net/http"
	"os"
)

func main() {

	http.HandleFunc("/health-check", healthCheckHandler)
	http.HandleFunc("/secret", secretHandler)

	err := http.ListenAndServe(":9290", nil)

	if err != nil {
		panic(err)
	}
}

func healthCheckHandler(writer http.ResponseWriter, _ *http.Request) {
	writer.WriteHeader(http.StatusOK)
	writer.Write([]byte("OK"))
}

func secretHandler(writer http.ResponseWriter, _ *http.Request) {
	writer.WriteHeader(http.StatusOK)
	writer.Write([]byte(os.Getenv("SECRET")))
}
