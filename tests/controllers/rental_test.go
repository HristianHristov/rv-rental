package controllers

import (
	"encoding/json"
	"net/http"
	"net/http/httptest"
	"os"
	"testing"

	"rv-rentals/internal/controllers"
	"rv-rentals/internal/models"

	"github.com/gin-gonic/gin"
	"github.com/stretchr/testify/assert"
	"gorm.io/driver/sqlite"
	"gorm.io/gorm"
)

var (
	testDB *gorm.DB
	router *gin.Engine
)

func TestMain(m *testing.M) {
	// Setup test database and router
	testDB = setupTestDatabase()

	router = setupRouter(testDB)

	// Run tests
	exitCode := m.Run()

	// Clean up and exit
	os.Exit(exitCode)
}

func setupTestDatabase() *gorm.DB {
	db, err := gorm.Open(sqlite.Open(":memory:"), &gorm.Config{})
	if err != nil {
		panic("Failed to connect to the test database: " + err.Error())
	}

	// AutoMigrate creates tables and applies migrations
	db.AutoMigrate(&models.User{}, &models.Rental{})

	// Seed some test data
	db.Create(&models.User{ID: 1, FirstName: "John", LastName: "Doe"})
	db.Create(&models.User{ID: 2, FirstName: "Alice", LastName: "Smith"})
	db.Create(&models.Rental{
		ID:          1,
		Name:        "RV1",
		Description: "RV Description 1",
		PricePerDay: 100,
		UserID:      1,
	})
	db.Create(&models.Rental{
		ID:          2,
		Name:        "RV2",
		Description: "RV Description 2",
		PricePerDay: 150,
		UserID:      2,
	})

	return db
}

func setupRouter(db *gorm.DB) *gin.Engine {
	r := gin.Default()

	// Initialize your controllers, passing the database instance
	rentalController := controllers.NewRentalHandler(db)

	// Define your routes
	r.GET("/api/rentals", rentalController.GetRentals)
	r.GET("/api/rentals/:id", rentalController.GetRentalByID)

	return r
}

func TestGetRentalByID(t *testing.T) {
	// Test a successful retrieval of a rental by ID
	t.Run("Successful retrieval of a rental by ID", func(t *testing.T) {
		w := performRequest("GET", "/api/rentals/1", router)
		assert.Equal(t, 200, w.Code)

		var response map[string]interface{}
		assert.NoError(t, json.Unmarshal(w.Body.Bytes(), &response))

		// Verify the response contains the expected rental data
		assert.Equal(t, float64(1), response["id"])
		assert.Equal(t, "RV1", response["name"])
		// Add more assertions for other fields
	})

	// Test a case where the rental with the given ID doesn't exist
	t.Run("Rental not found by ID", func(t *testing.T) {
		w := performRequest("GET", "/api/rentals/100", router)
		assert.Equal(t, 404, w.Code)

		var response map[string]interface{}
		assert.NoError(t, json.Unmarshal(w.Body.Bytes(), &response))

		// Verify that the response contains the error message
		assert.Equal(t, "Rental not found", response["error"])
	})

}

func TestGetRentals(t *testing.T) {
	// Test a successful retrieval of rentals
	t.Run("Successful retrieval of rentals", func(t *testing.T) {
		w := performRequest("GET", "/api/rentals", router)
		assert.Equal(t, 200, w.Code)

		var response []map[string]interface{}
		assert.NoError(t, json.Unmarshal(w.Body.Bytes(), &response))

		// Verify the response contains the expected number of rentals
		assert.Len(t, response, 2)

	})
}

// Helper function to perform HTTP requests for testing
func performRequest(method, path string, router *gin.Engine) *httptest.ResponseRecorder {
	w := httptest.NewRecorder()
	req, _ := http.NewRequest(method, path, nil)
	router.ServeHTTP(w, req)
	return w
}
