package exercise

import (
	"image/color"
	"math/cmplx"
	"sync"
	"github.com/dikderoy/imagen/drawer"
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

func (m Mandelbrot) Generate(canvas *drawer.Image) error {
	const left, bottom, right, up = -2, -2, 2, 2

	for dy := 0; dy < canvas.Height; dy++ {
		y := bottom + float64(dy)/float64(canvas.Height)*(up-bottom)

		for dx := 0; dx < canvas.Width; dx++ {
			x := left + float64(dx)/float64(canvas.Width)*(right-left)
			canvas.Set(dx, dy, m.getColor(complex(x, y)))
		}
	}

	return nil
}

func (m Mandelbrot) GenerateParallel(canvas *drawer.Image) error {
	waitGroup := sync.WaitGroup{}
	const left, bottom, right, up = -2, -2, 2, 2
	for dy := 0; dy < canvas.Height; dy++ {
		y := bottom + float64(dy)/float64(canvas.Height)*(up-bottom)

		for dx := 0; dx < canvas.Width; dx++ {
			x := left + float64(dx)/float64(canvas.Width)*(right-left)
			waitGroup.Add(1)
			go func(px, py int) {
				canvas.Set(px, py, m.getColor(complex(x, y)))
				waitGroup.Done()
			}(dx, dy)
		}
	}
	return nil
}

func (m Mandelbrot) getColor(z complex128) color.Color {
	var v complex128
	var i = 0
	for ; i < m.iterations && cmplx.Abs(v) <= 2; i++ {
		v = v*v + z
	}
	if cmplx.Abs(v) <= 2 {
		return color.Black
	}
	return color.YCbCr{Y: 255 - 15*uint8(i), Cb: 15 * uint8(i), Cr: 255 - 15*uint8(i)}
}
