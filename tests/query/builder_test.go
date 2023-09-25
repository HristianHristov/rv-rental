package query

import (
	"testing"

	"rv-rentals/internal/models"
	"rv-rentals/internal/query"

	"github.com/stretchr/testify/assert"
	"gorm.io/driver/sqlite"
	"gorm.io/gorm"
)

func setupTestDatabase() *gorm.DB {
	db, err := gorm.Open(sqlite.Open(":memory:"), &gorm.Config{})
	if err != nil {
		panic("Failed to connect to the test database: " + err.Error())
	}

	// Run database migrations and seed data for testing.

	return db
}

func TestBuildRentalQuery(t *testing.T) {
	db := setupTestDatabase()
	var rentals models.Rental
	t.Run("BuildQueryWithID", func(t *testing.T) {
		params := query.RentalQueryParams{
			ID: "1,2,3",
		}
		query := query.BuildRentalQuery(params, db)
		query = query.Session(&gorm.Session{DryRun: true}).First(&rentals, 1)
		assert.Contains(t, query.Statement.SQL.String(), "id IN (?,?,?)")
	})

	t.Run("BuildQueryWithMinPrice", func(t *testing.T) {
		var rentals models.Rental
		params := query.RentalQueryParams{
			MinPrice: 100,
		}
		query := query.BuildRentalQuery(params, db)
		query = query.Session(&gorm.Session{DryRun: true}).First(&rentals, 1)
		assert.Contains(t, query.Statement.SQL.String(), "price_per_day >= ?")
	})

	t.Run("BuildQueryWithMaxPrice", func(t *testing.T) {
		var rentals models.Rental
		params := query.RentalQueryParams{
			MaxPrice: 500,
		}
		query := query.BuildRentalQuery(params, db)
		query = query.Session(&gorm.Session{DryRun: true}).First(&rentals, 1)
		assert.Contains(t, query.Statement.SQL.String(), "price_per_day <= ?")
	})

	t.Run("BuildQueryWithNear", func(t *testing.T) {
		var rentals models.Rental
		params := query.RentalQueryParams{
			Near: query.FloatList("33.64,-117.93"),
		}
		query := query.BuildRentalQuery(params, db)
		query = query.Session(&gorm.Session{DryRun: true}).First(&rentals, 1)
		assert.Contains(t, query.Statement.SQL.String(), "haversine(lat,lng,?,?) <= ?")
	})

	t.Run("BuildQueryWithSort", func(t *testing.T) {
		var rentals models.Rental
		params := query.RentalQueryParams{
			Sort: "price",
		}
		query := query.BuildRentalQuery(params, db)
		query = query.Session(&gorm.Session{DryRun: true}).First(&rentals, 1)
		assert.Contains(t, query.Statement.SQL.String(), "ORDER BY price_per_day")
	})
}
