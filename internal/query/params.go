package query

import (
	"strconv"
	"strings"
)

type RentalQueryParams struct {
	ID       IntList   `form:"ids"`
	MinPrice int       `form:"min_price"`
	MaxPrice int       `form:"max_price"`
	Limit    int       `form:"limit"`
	Offset   int       `form:"offset"`
	Near     FloatList `form:"near"`
	Sort     string    `form:"sort"`
}

type IntList string

func (il IntList) Values() []int {
	res := []int{}

	str := string(il)
	if len(str) > 0 {
		values := strings.Split(str, ",")
		for _, v := range values {
			if i, err := strconv.Atoi(v); err == nil {
				res = append(res, int(i))
			}
		}
	}

	if len(res) == 0 {
		return nil
	}
	return res
}

type FloatList string

func (fl FloatList) Values() []float32 {
	res := []float32{}

	str := string(fl)
	if len(str) > 0 {
		values := strings.Split(str, ",")
		for _, v := range values {
			if f, err := strconv.ParseFloat(v, 32); err == nil {
				res = append(res, float32(f))
			}
		}
	}

	if len(res) == 0 {
		return nil
	}
	return res
}
