package main

import (
	"fmt"
	"os"
	"rv-rentals/config"
	"rv-rentals/internal/controllers"

	"github.com/gin-gonic/gin"
)

func main() {

	// Define the database configuration using environment variables
	dbHost := os.Getenv("DBHOST")
	dbUser := os.Getenv("DBUSER")
	dbPassword := os.Getenv("DBPASSWORD")
	dbName := os.Getenv("DBNAME")
	dbPort := os.Getenv("DBPORT")

	// Construct the DSN
	dsn := fmt.Sprintf("host=%s user=%s password=%s dbname=%s port=%s sslmode=disable", dbHost, dbUser, dbPassword, dbName, dbPort)

	// Create a new Database instance
	db, err := config.NewDatabase(dsn)
	if err != nil {
		panic("Failed to connect to the database: " + err.Error())
	}

	// Create a new Gin router
	router := gin.Default()

	// Initialize your controllers, passing the database instance
	rentalController := controllers.NewRentalHandler(db)

	// Define your routes
	router.GET("/api/rentals", rentalController.GetRentals)
	router.GET("/api/rentals/:id", rentalController.GetRentalByID)

	// Start the server
	router.Run(":8081")
}
