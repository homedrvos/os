package main

import (
	"io/ioutil"
	"log"
	"os"
	"text/template"
)

func main() {
	t, err := template.New("schema_template").ParseFiles("./scripts/schema_template")
	if err != nil {
		log.Fatal(err)
	}

	schema, err := ioutil.ReadFile("./scripts/schema.json")
	if err != nil {
		log.Fatal(err)
	}

	inlinedFile, err := os.Create("config/schema.go")
	if err != nil {
		log.Fatal(err)
	}

	if err := t.Execute(inlinedFile, map[string]string{
		"schema": string(schema),
	}); err != nil {
		log.Fatal(err)
	}
}
