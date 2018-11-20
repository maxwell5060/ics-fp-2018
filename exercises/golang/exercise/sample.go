package exercise

import (
	"github.com/dikderoy/imagen/golang/drawer"
	"image/color"
	"sync"
	"math/cmplx"
)

type Mandelbrot struct {
	iterations  int
	scaleFactor float32
	offsetX     float32
	offsetY     float32
}

func NewMandelbrot(iterations int, scaleFactor float32, offsetX, offsetY float32) drawer.MandelbrotGenerator {
	return Mandelbrot{iterations: iterations, scaleFactor: scaleFactor, offsetX: offsetX, offsetY: offsetY}
}

func (m Mandelbrot) Generate(canvas *drawer.Image) error { //MandelbrotGenerator.Generate implementation
	for dy := 0; dy < canvas.Height; dy++ {
		for dx := 0; dx < canvas.Width; dx++ {
			y := float64(dy)/float64(canvas.Height)
			x := float64(dx)/float64(canvas.Width)
			canvas.Set(dx, dy, m.calculatePixelColour(complex(x, y)))
		}
	}
	return nil //no errors if 'nil'
}

func (m Mandelbrot) GenerateParallel(canvas *drawer.Image) error { //MandelbrotGenerator.GenerateParallel implementation
	wg := sync.WaitGroup{}
	for dy := 0; dy < canvas.Height; dy++ {
		for dx := 0; dx < canvas.Width; dx++ {
			y := float64(dy)/float64(canvas.Height)
			x := float64(dx)/float64(canvas.Width)
			wg.Add(1)
			canvas.Set(dx, dy, m.calculatePixelColour(complex(y, x)))
			wg.Done()
		}
	}
	return nil //no errors if 'nil'
}

func (m Mandelbrot) calculatePixelColour(c complex128) color.Color { //package-private
	var z complex128

	for i := 0; i < m.iterations && cmplx.Abs(z) <= 2; i++ {
		// z(0) = 0
		// z(n+1) = z(n)^5 + c
		z = cmplx.Pow(z, 5) + c
	}
	if cmplx.Abs(z) <= 4 {
		return color.Black
	}
	return color.White
}