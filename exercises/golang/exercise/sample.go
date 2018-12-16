package exercise

import (
	"github.com/dikderoy/imagen/drawer"
	"image/color"
	//log "github.com/sirupsen/logrus"
	"sync"
)

type Mandelbrot struct {
	iterations int
	scaleFactor, offsetX, offsetY float32
}


func NewMandelbrot(iterations int, scaleFactor float32, offsetX, offsetY float32) drawer.MandelbrotGenerator {
	return Mandelbrot{iterations, scaleFactor, offsetX, offsetY}
}

func (m Mandelbrot) Generate(canvas *drawer.Image) error {
	const constSpace = 3
	
	for y := 0; y < canvas.Height; y++ {
		for x := 0; x < canvas.Width; x++ {
			pixY := -constSpace + float64(y)/float64(canvas.Height)*(constSpace*2)
			pixX := -constSpace + float64(x)/float64(canvas.Width)*(constSpace*2)
			canvas.Set(x, y, m.getPix(complex(pixX, pixY)))
		}
	}
	
	return nil
}


func (m Mandelbrot) GenerateParallel(canvas *drawer.Image) error {
	const constSpace = 3
	wg := sync.WaitGroup{}
	
	for y := 0; y < canvas.Height; y++ {
		for x := 0; x < canvas.Width; x++ {
			pixY := -constSpace + float64(y)/float64(canvas.Height)*(constSpace*2)
			pixX := -constSpace + float64(x)/float64(canvas.Width)*(constSpace*2)
			wg.Add(1)
			canvas.Set(x, y, m.getColor(complex(pixY, pixX)))
			wg.Add(1)
			
		}
	}
	return nil
}

func (m Mandelbrot) getColor(xy complex128) color.Color {
	x := float32(0)
	y := float32(0)

	for i := 0; i < m.iterations; i++ {
		xValue := x*x - y*y + x0
		y = 2.0*x*y + y0
		x = xValue
		if x*x+y*y > 4 {
			return color.YCbCr{255 - 20*uint8(i), 128, 128}
		}
	}

	return color.Black
}

