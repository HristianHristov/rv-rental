package query

import (
	"rv-rentals/internal/models"

	"gorm.io/gorm"
)

func BuildRentalQuery(params RentalQueryParams, db *gorm.DB) *gorm.DB {

	query := db.Model(&models.Rental{})

	if len(params.ID) != 0 {
		query = query.Where("id IN ?", params.ID.Values())
	}
	if params.MinPrice > 0 {
		query = query.Where("price_per_day >= ?", params.MinPrice)
	}
	if params.MaxPrice > 0 {
		query = query.Where("price_per_day <= ?", params.MaxPrice)
	}
	if len(params.Near.Values()) == 2 {
		println(params.Near.Values())
		// Calculate the Haversine distance and filter by distance <= 100 miles, custom function in SQL
		values := params.Near.Values()
		query = query.Where("haversine(lat,lng,?,?) <= ?", values[0], values[1], 100.0)
		println(query.Statement.SQL.String())
	}
	if params.Limit > 0 {
		query = query.Limit(params.Limit)
	}
	if params.Offset > 0 {
		query = query.Offset(params.Offset)
	}
	if params.Sort != "" {

		query = query.Order(mapSortParam(params.Sort))
	}
	return query
}

func mapSortParam(sortParam string) string {
	if sortParam == "price" {
		return "price_per_day"
	}
	return sortParam
}
