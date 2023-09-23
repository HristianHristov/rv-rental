package query

import (
	"rv-rentals/internal/models"

	"gorm.io/gorm"
)

func BuildRentalQuery(params RentalQueryParams, db *gorm.DB) *gorm.DB {

	query := db.Model(&models.Rental{})

	if len(params.ID) != 0 {
		query = query.Where("user_id = ?", params.ID)
	}
	if params.MinPrice > 0 {
		query = query.Where("price >= ?", params.MinPrice)
	}
	if params.MaxPrice > 0 {
		query = query.Where("price <= ?", params.MaxPrice)
	}
	if params.Limit > 0 {
		query = query.Limit(params.Limit)
	}
	if params.Offset > 0 {
		query = query.Offset(params.Offset)
	}
	if params.Sort != "" {
		query = query.Order(params.Sort)
	}
	return query
}
