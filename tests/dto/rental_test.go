package dto

import (
	"rv-rentals/internal/dto"
	"rv-rentals/internal/models"
	"testing"

	"github.com/stretchr/testify/assert"
)

func TestRentalToDTO(t *testing.T) {
	// Create a sample Rental model
	rental := models.Rental{
		ID:          1,
		Name:        "Sample Rental",
		PricePerDay: 100.0,
	}

	// Create a sample User model
	user := models.User{
		ID:        1,
		FirstName: "Sample User",
		// Add other fields as needed
	}

	// Call the DTO function
	rentalDTO := dto.RentalToDTO(rental, user)

	// Assert that the DTO contains the expected values
	assert.Equal(t, rentalDTO.ID, rental.ID)
	assert.Equal(t, rentalDTO.Name, rental.Name)

	// Add other assertions for user-related fields
}
