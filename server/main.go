package main

import (
	"encoding/json"
	"log"
	"net/http"
	"os"
)

// Define the struct
type UserInfo struct {
	Name      string  `json:"name"`
	UserEmail string  `json:"userEmail"`
	Balance   float64 `json:"balance"`
	XP        int     `json:"XP"`
	Category  string  `json:"category"`
	Level     string  `json:"level"`
}

// Handler function for /api/info
func infoHandler(w http.ResponseWriter, r *http.Request) {
	// Create a dummy user object
	dummy := UserInfo{
		Name:      "John Doe",
		UserEmail: "john.doe@example.com",
		Balance:   1234.56,
		XP:        500,
		Category:  "L1",
		Level:     "Lv1",
	}

	// Set response headers
	w.Header().Set("Content-Type", "application/json")

	// Convert struct to JSON and write response
	if err := json.NewEncoder(w).Encode(dummy); err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
	}
}

// Read a.json and return that data at market name
func readJSONFile(filename string) (map[string]interface{}, error) {
	file, err := os.Open(filename)
	if err != nil {
		return nil, err
	}
	defer file.Close()

	var data map[string]interface{}
	if err := json.NewDecoder(file).Decode(&data); err != nil {
		return nil, err
	}

	return data, nil
}

var marketdata []byte

func getMarketData() ([]byte, error) {
	if len(marketdata) > 0 {
		return marketdata, nil
	}
	data, err := os.ReadFile("a.json")
	if err == nil {
		marketdata = data
	}
	return nil, err
}
func marketHandler(w http.ResponseWriter, r *http.Request) {
	data, err := getMarketData()
	if err != nil {
		http.Error(w, err.Error(), http.StatusNotFound)
		return
	}

	w.Header().Set("Content-Type", "application/json")
	w.Write(data)
}
func main() {
	port := os.Getenv("PORT") // Set environment variable
	http.HandleFunc("/user/info", infoHandler)
	http.HandleFunc("/market/extra", marketHandler)

	log.Println("Server running on", port)
	log.Fatal(http.ListenAndServe(port, nil))
}
