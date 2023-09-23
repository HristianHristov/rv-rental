package query

type RentalQueryParams struct {
	ID       []uint
	MinPrice int
	MaxPrice int
	Limit    int
	Offset   int
	Near     []int
	Sort     string
}
