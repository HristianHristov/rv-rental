package dto

import "rv-rentals/internal/models"

type RentalDTO struct {
	ID              uint        `json:"id"`                // int
	Name            string      `json:"name"`              // string
	Description     string      `json:"description"`       // string
	Type            string      `json:"type"`              // string
	Make            string      `json:"make"`              // string
	Model           string      `json:"model"`             // string
	Year            int         `json:"year"`              // int
	Length          float64     `json:"length"`            // decimal
	Sleeps          int         `json:"sleeps"`            // int
	PrimaryImageURL string      `json:"primary_image_url"` // string
	Price           PriceDTO    `json:"price"`             // int
	Location        LocationDTO `json:"location"`          // LocationDTO
	User            UserDTO     `json:"user"`              // UserDTO
}

type UserDTO struct {
	ID        uint   `json:"id"`
	FirstName string `json:"first_name"`
	LastName  string `json:"last_name"`
}

type LocationDTO struct {
	City    string  `json:"city"`
	State   string  `json:"state"`
	Zip     string  `json:"zip"`
	Country string  `json:"country"`
	Lat     float64 `json:"latitude"`
	Lng     float64 `json:"longitude"`
}

type PriceDTO struct {
	Day int64 `json:"day"`
}

// RentalToDTO converts a Rental model to a RentalDTO
func RentalToDTO(rental models.Rental, user models.User) RentalDTO {
	return RentalDTO{
		ID:              rental.ID,
		Name:            rental.Name,
		Description:     rental.Description,
		Type:            rental.Type,
		Make:            rental.VehicleMake,
		Model:           rental.VehicleModel,
		Year:            rental.VehicleYear,
		Length:          rental.VehicleLength,
		Sleeps:          rental.Sleeps,
		PrimaryImageURL: rental.PrimaryImageURL,
		Price: PriceDTO{
			Day: rental.PricePerDay,
		},
		Location: LocationDTO{
			City:    rental.HomeCity,
			State:   rental.HomeState,
			Zip:     rental.HomeZip,
			Country: rental.HomeCountry,
			Lat:     rental.Lat,
			Lng:     rental.Lng,
		},
		User: UserDTO{
			ID:        user.ID,
			FirstName: user.FirstName,
			LastName:  user.LastName,
		},
	}
}
