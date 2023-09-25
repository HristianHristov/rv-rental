package controllers

import (
	"rv-rentals/internal/dto"
	"rv-rentals/internal/models"
	"rv-rentals/internal/query"
	"strconv"

	"github.com/gin-gonic/gin"
	"gorm.io/gorm"
)

type rentalHandler struct {
	db *gorm.DB
}

func NewRentalHandler(db *gorm.DB) *rentalHandler {
	return &rentalHandler{
		db: db,
	}
}

// Define the controller function to get a rental by ID
func (rh *rentalHandler) GetRentalByID(c *gin.Context) {
	// Parse the rental ID from the URL parameters
	rentalID := c.Param("id")

	// Validate the rental ID (e.g., check if it's a valid integer)
	rentalIDUint, err := strconv.ParseUint(rentalID, 10, 64)
	if err != nil {
		c.JSON(400, gin.H{"error": "Invalid rental ID"})
		return
	}

	// Query the database to fetch the rental by ID
	var rental models.Rental
	if err := rh.db.First(&rental, rentalIDUint).Error; err != nil {
		c.JSON(404, gin.H{"error": "Rental not found"})
		return
	}

	// Convert the rental to a DTO
	rentalDTO := dto.RentalToDTO(rental, rental.User)

	// Return the rental DTO as JSON
	c.JSON(200, rentalDTO)
}

func (rh *rentalHandler) GetRentals(c *gin.Context) {
	// Parse query parameters from the request
	var queryParams query.RentalQueryParams

	if err := c.ShouldBindQuery(&queryParams); err != nil {
		c.JSON(400, gin.H{"error": "Invalid query parameters"})
		return
	}

	// Build the query based on the parameters
	query := query.BuildRentalQuery(queryParams, rh.db)

	// Execute the query to fetch rentals
	var rentals []models.Rental
	if err := query.Debug().Preload("User").Find(&rentals).Error; err != nil {
		c.JSON(500, gin.H{"error": "Failed to fetch rentals"})
		return
	}

	// Convert rentals to DTOs and return as JSON
	rentalDTOs := make([]dto.RentalDTO, len(rentals))
	for i, rental := range rentals {
		rentalDTOs[i] = dto.RentalToDTO(rental, rental.User)
	}

	c.JSON(200, rentalDTOs)
}
