package exercise

import (
	"github.com/dikderoy/imagen/drawer"
	"image/color"
	"math/cmplx"
	"sync"
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

func (m Mandelbrot) projectX(x int, width int) float64 {
	return -2 + float64(x)/float64(width)*(2.5)
}

func (m Mandelbrot) projectY(y int, height int) float64 {
	return -1 + float64(y)/float64(height)*(2)
}

func (m Mandelbrot) projectPixel(x int, y int, width int, height int) complex128 {
	pixelY := m.projectY(y, height)
	pixelX := m.projectX(x, width)
	return complex(pixelX, pixelY)
}


func (m Mandelbrot) Generate(canvas *drawer.Image) error {
	for y := 0; y < canvas.Height; y++ {
		for x := 0; x < canvas.Width; x++ {
			canvas.Set(x, y, m.getPixelColor(m.projectPixel(x, y, canvas.Width, canvas.Height)))
		}
	}
	return nil
}

func (m Mandelbrot) GenerateParallel(canvas *drawer.Image) error {
	wg := sync.WaitGroup{}
	for y := 0; y < canvas.Height; y++ {
		for x := 0; x < canvas.Width; x++ {
			wg.Add(1)
			canvas.Set(x, y, m.getPixelColor(m.projectPixel(x, y, canvas.Width, canvas.Height)))
			wg.Add(1)
		}
	}
	return nil
}

func (m Mandelbrot) iterate(c complex128) complex128 {
	var z complex128
	var i = 0
	for ; i < m.iterations && cmplx.Abs(z) <= 2; i++ {
		z = (z*z) + c
	}
	return z
}

func (m Mandelbrot) getPixelColor(c complex128) color.Color {
	z := m.iterate(c)
	if cmplx.Abs(z) <= 2 {
		return color.YCbCr{Y: 16, Cb: 128, Cr:128} //black color for mandelbort set
	}
	return color.YCbCr{Y: 235, Cb: 128, Cr: 128} //white color for non mandelbort set
}



