package exercise

import (
	"image/color"
	"sync"

	"github.com/dikderoy/imagen/drawer"
)

type MandelbrotGenerator_impl struct {
	iterations       int
	scaleFactor      float32
	offsetX, offsetY float32
}

func NewMandelbrot(iterations int, scaleFactor float32, offsetX, offsetY float32) drawer.MandelbrotGenerator {
	return MandelbrotGenerator_impl{iterations, scaleFactor, offsetX, offsetY}
}

func (g MandelbrotGenerator_impl) GetColor(x0, y0 float32) color.Color {
	x := float32(0)
	y := float32(0)

	for i := 0; i < g.iterations; i++ {
		xtemp := x*x - y*y + x0
		y = 2.0*x*y + y0
		x = xtemp
		if x*x+y*y > 4 {
			return color.YCbCr{255 - 20*uint8(i), 128, 128}
		}
	}

	return color.Black
}

func (g MandelbrotGenerator_impl) Generate(canvas *drawer.Image) error {

	for iy := 0; iy < canvas.Height; iy++ {
		y := (float32(iy)/float32(canvas.Height)-0.5)/g.scaleFactor - g.offsetY

		for ix := 0; ix < canvas.Width; ix++ {
			x := (float32(ix)/float32(canvas.Width)-0.5)/g.scaleFactor - g.offsetX

			canvas.Set(ix, iy, g.GetColor(x, y))
		}
	}

	return nil
}

func (g MandelbrotGenerator_impl) GenerateParallel(canvas *drawer.Image) error {
	wg := sync.WaitGroup{}

	for iy := 0; iy < canvas.Height; iy++ {
		y := (float32(iy)/float32(canvas.Height)-0.5)/g.scaleFactor - g.offsetY

		for ix := 0; ix < canvas.Width; ix++ {
			x := (float32(ix)/float32(canvas.Width)-0.5)/g.scaleFactor - g.offsetX

			wg.Add(1)

			go func(ix, iy int) {
				canvas.Set(ix, iy, g.GetColor(x, y))
				wg.Done()
			}(ix, iy)
		}
	}

	return nil
}
