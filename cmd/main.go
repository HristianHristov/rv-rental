package main

import (
	"rv-rentals/config"
	"rv-rentals/internal/controllers"

	"github.com/gin-gonic/gin"
)

func main() {
	// Define the database configuration
	dsn := "host=localhost user=root password=root dbname=testingwithrentals port=5434 sslmode=disable"

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
	api := router.Group("/api")

	// Define routes related to rentals
	rentals := api.Group("/rentals")
	{
		rentals.GET("/:id", rentalController.GetRentalByID)
		rentals.GET("/", rentalController.GetRentals)
	}

	// Start the server
	router.Run(":8081")
}
