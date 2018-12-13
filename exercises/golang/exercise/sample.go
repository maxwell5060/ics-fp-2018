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
	for iy := 0; iy < canvas.Height; iy++ {
		y := float64(iy)/float64(canvas.Height)*(-8) + 4
		for ix := 0; ix < canvas.Width; ix++ {
			x := float64(ix)/float64(canvas.Width)*(-8) + 4
			canvas.Set(ix, iy, m.getColour(complex(x, y)))
		}
	}
	return nil
}

func (m Mandelbrot) GenerateParallel(canvas *drawer.Image) error {
	wg := sync.WaitGroup{}
	for iy := 0; iy < canvas.Height; iy++ {
		y := float64(iy)/float64(canvas.Height)*(-8) + 4
		for ix := 0; ix < canvas.Width; ix++ {
			x := float64(ix)/float64(canvas.Width)*(-8) + 4
			wg.Add(1)
			canvas.Set(ix, iy, m.getColour(complex(x, y)))
			wg.Add(1)
		}
	}
	return nil
}

func (m Mandelbrot) getColour(xy complex128) color.Color {
	var f complex128
	for i := uint8(0); i < uint8(m.iterations); i++ {
		f = f*f*f + xy
		if cmplx.Abs(f) > 3 {
			return color.YCbCr{255 - 10*i, 100 - 2*i, 100}
		}
		if cmplx.Abs(f) > 2 && cmplx.Abs(f) <= 3 {
			return color.YCbCr{255 - 15*i, 0, 100}
		}
	}
	return color.Black
}
