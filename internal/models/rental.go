package models

import "time"

type Rental struct {
	ID              uint `gorm:"primary_key"`
	UserID          uint
	Name            string
	Type            string
	Description     string
	Sleeps          int
	PricePerDay     int64
	HomeCity        string
	HomeState       string
	HomeZip         string
	HomeCountry     string
	VehicleMake     string
	VehicleModel    string
	VehicleYear     int
	VehicleLength   float64
	CreatedAt       time.Time
	UpdatedAt       time.Time
	Lat             float64
	Lng             float64
	PrimaryImageURL string
	User            User
}

type Location struct {
	HomeCity    string
	HomeState   string
	HomeZip     string
	HomeCountry string
	Lat         float64
	Lng         float64
}
