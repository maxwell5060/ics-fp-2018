package exercise

import (
	"github.com/dikderoy/imagen/drawer"
	"image/color"
	"errors"
	"math/cmplx"
	"sync"
)

type Mandelbrot struct{
	iterations int
	scaleFactor float32
	offsetX, offsetY float32
	}

var palette []color.RGBA

func (mandelbrot Mandelbrot) Generate(canvas *drawer.Image) error {

	if (mandelbrot.iterations <= 0) {
		return errors.New("Incorrect params")
	}

	for i := 0; i < canvas.Width; i++ {
        for j := 0; j < canvas.Height; j++  {
           mandelbrot.fillPixel(canvas, i, j)
        }
    }

	return nil
}

func (mandelbrot Mandelbrot) GenerateParallel(canvas *drawer.Image) error {
	if (mandelbrot.iterations <= 0) {
		return errors.New("Incorrect params")
	}

	var wg sync.WaitGroup
    wg.Add(3)
    for i := 0; i < canvas.Width; i++ {
        go func(i int) {
            for j := 0; j < canvas.Height; j++  {
                mandelbrot.fillPixel(canvas, i, j)
            }
            wg.Done()
        }(i)
    }
    wg.Wait()

	return nil
}

func (mandelbrot Mandelbrot) fillPixel(canvas *drawer.Image, x, y int) {
    dy := float64((float32(y) * mandelbrot.scaleFactor))
    dx := float64((float32(x) * mandelbrot.scaleFactor))
    canvas.Set(x, y, mandelbrot.getColor(complex(dx, dy)))
}

func NewMandelbrot(iterations int, scaleFactor float32, offsetX, offsetY float32) drawer.MandelbrotGenerator {
	//start here

	return Mandelbrot{iterations, scaleFactor, offsetX, offsetY}
}

func (mandelbrot Mandelbrot) getColor(c complex128) color.Color {
    z := c
    i := 0
    for ; i < mandelbrot.iterations && cmplx.Abs(z) <= 2; i++ {
        z = cmplx.Pow(z, 2) + c
    }
    if cmplx.Abs(z) > 2 {
        return color.YCbCr{Y: 255 - 15*uint8(i), Cb: 15 * uint8(i), Cr: 255 - 15*uint8(i)}
    }
    return color.Black
}