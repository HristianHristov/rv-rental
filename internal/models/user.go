package models

type User struct {
	ID        uint `gorm:"primary_key"`
	FirstName string
	LastName  string
}
