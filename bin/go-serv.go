package main

import (
	"flag"
	"fmt"
	"net/http"
	"os"
)

var port string

func init() {
	flag.StringVar(&port, "p", "4321", "port number")
}

func main() {
	flag.Parse()

	currDir, err := os.Getwd()
	if err != nil {
		panic(err)
	}

	fmt.Printf("Serving %s on localhost:%s/\n", currDir, port)
	err = http.ListenAndServe(fmt.Sprintf(":%s", port), http.FileServer(http.Dir(currDir)))
	panic(err)
}
