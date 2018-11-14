package exercise

import (
	"image/color"
	"math/cmplx"
	"sync"

	"github.com/dikderoy/imagen/drawer"
)

// Mandelbrot contains information for performing Mandelbrot calculations
type Mandelbrot struct {
	iterations       int
	scaleFactor      float32
	offsetX, offsetY float32
}

func (m Mandelbrot) calculateColor(z complex128) color.Color {
	var v complex128

	for n := uint8(0); n < uint8(m.iterations); n++ {
		v = v*v + z

		if cmplx.Abs(v) > 2 {
			return color.YCbCr{255 - 15*n, 0 + 15*n, 255 - 15*n}
		}
	}

	return color.Black
}

// Generate calculates color for each pixel
func (m Mandelbrot) Generate(canvas *drawer.Image) error {
	const xmin, ymin, xmax, ymax = -2, -2, +2, +2

	for py := 0; py < canvas.Height; py++ {
		y := float64(py)/float64(canvas.Height)*(ymax-ymin) + ymin

		for px := 0; px < canvas.Width; px++ {
			x := float64(px)/float64(canvas.Width)*(xmax-xmin) + xmin
			z := complex(x, y)

			canvas.Set(px, py, m.calculateColor(z))
		}
	}

	return nil
}

// GenerateParallel calculates color for each pixel in parallel
func (m Mandelbrot) GenerateParallel(canvas *drawer.Image) error {
	wg := sync.WaitGroup{}

	const xmin, ymin, xmax, ymax = -2, -2, +2, +2

	for py := 0; py < canvas.Height; py++ {
		y := float64(py)/float64(canvas.Height)*(ymax-ymin) + ymin

		for px := 0; px < canvas.Width; px++ {
			x := float64(px)/float64(canvas.Width)*(xmax-xmin) + xmin
			z := complex(x, y)

			wg.Add(1)

			go func(px, py int) {
				canvas.Set(px, py, m.calculateColor(z))
				wg.Done()
			}(px, py)
		}
	}

	return nil
}

// NewMandelbrot initializes Mandelbrot
func NewMandelbrot(iterations int, scaleFactor float32, offsetX, offsetY float32) drawer.MandelbrotGenerator {
	return Mandelbrot{
		iterations:  iterations,
		scaleFactor: scaleFactor,
		offsetX:     offsetX,
		offsetY:     offsetY,
	}
}
