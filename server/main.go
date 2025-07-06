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
		Category:  "Pro",
		Level:     "Intermediate",
	}

	// Set response headers
	w.Header().Set("Content-Type", "application/json")

	// Convert struct to JSON and write response
	if err := json.NewEncoder(w).Encode(dummy); err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
	}
}

func main() {
	port := os.Getenv("PORT") // Set environment variable
	http.HandleFunc("/api/info", infoHandler)

	log.Println("Server running on", port)
	log.Fatal(http.ListenAndServe(port, nil))
}
