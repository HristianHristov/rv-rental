package config

import (
	"gorm.io/driver/postgres"
	"gorm.io/gorm"
)

// NewDatabase creates a new Database instance.
func NewDatabase(dsn string) (*gorm.DB, error) {
	db, err := gorm.Open(postgres.Open(dsn), &gorm.Config{})
	if err != nil {
		return nil, err
	}

	// db.AutoMigrate(models.User{}, models.Rental{})

	return db, nil
}
