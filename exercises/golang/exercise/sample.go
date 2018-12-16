package exercise

import (
	"image/color"

	"github.com/dikderoy/imagen/drawer"

	"math/cmplx"
	"sync"
)

type Mandelbrot struct {
	iterations  int
	scaleFactor float32
	offsetX     float32
	offsetY     float32
}

const (
	left   = -2
	bottom = -1
)

func NewMandelbrot(iterations int, scaleFactor float32, offsetX, offsetY float32) drawer.MandelbrotGenerator {
	return Mandelbrot{iterations: iterations, scaleFactor: scaleFactor, offsetX: offsetX, offsetY: offsetY}
}

func (mlb Mandelbrot) pixelColor(z complex128) color.RGBA {
	var c complex128
	for n := 0; n < mlb.iterations; n++ {
		if cmplx.Abs(c) > 2 {
			calcval := int(float64(n-1) / float64(mlb.iterations) * 255)
			return color.RGBA{
				uint8(2 * calcval % 255),
				uint8(3 * calcval % 255),
				uint8(1 * calcval % 255),
				255}
		}
		c = c*c + z
	}

	return color.RGBA{
		uint8(0),
		uint8(0),
		uint8(0),
		255}
}

func (mlb Mandelbrot) Generate(canvas *drawer.Image) error {

	for y := 0; y < canvas.Height; y++ {
		dy := bottom + float32(y)*mlb.scaleFactor
		for x := 0; x < canvas.Width; x++ {
			dx := left + float32(x)*mlb.scaleFactor
			canvas.Set(x, y, mlb.pixelColor(complex(float64(dx), float64(dy))))
		}
	}
	return nil
}

func (mlb Mandelbrot) GenerateParallel(canvas *drawer.Image) error {
	waitGroup := sync.WaitGroup{}
	for y := 0; y < canvas.Height; y++ {
		dy := bottom + float32(y)*mlb.scaleFactor
		for x := 0; x < canvas.Width; x++ {
			dx := left + float32(x)*mlb.scaleFactor
			waitGroup.Add(1)
			go func(px, py int) {
				canvas.Set(px, py, mlb.pixelColor(complex(float64(dx), float64(dy))))
				waitGroup.Done()
			}(x, y)
		}
	}
	return nil
}

