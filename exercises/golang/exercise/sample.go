package exercise

import (
	"github.com/dikderoy/imagen/drawer"
	log "github.com/sirupsen/logrus"
	"image/color"
	"math/cmplx"
	"sync"
)

type Mandelbrot struct {
	iterations      	int
	scaleFactor     	float32
	offsetX, offsetY	float32
}

func NewMandelbrot(iterations int, scaleFactor float32, offsetX, offsetY float32) drawer.MandelbrotGenerator {
	return Mandelbrot{iterations: iterations, scaleFactor: scaleFactor, offsetX: offsetX, offsetY: offsetY}
}

func (m Mandelbrot) GetColor(xy complex128) color.Color {
    f := xy
    for i := 0; i < mandelbrot.iterations && cmplx.Abs(f) <= 2; i++ {
        f = cmplx.Pow(f, 2) + xy
    }
    if cmplx.Abs(f) > 2 {
        return color.YCbCr{Y: 255 - 15*uint8(i), Cb: 15 * uint8(i), Cr: 255 - 15*uint8(i)}
    }
    return color.Black
}

func (m Mandelbrot) Generate(canvas *drawer.Image) error {
	if (mandelbrot.iterations <= 0) {
		return errors.New("Sry, incorrect params")
	}
	
	for dy := 0; dy < canvas.Height; dy++ {
		for dx := 0; dx < canvas.Width; dx++ {
			y := float64(dy)/float64(canvas.Height)
			x := float64(dx)/float64(canvas.Width)
			canvas.Set(dx, dy, m.GetColor(complex(x, y)))
		}
	}
	return nil 
}
func (m Mandelbrot) GenerateParallel(canvas *drawer.Image) error { 
	if (mandelbrot.iterations <= 0) {
		return errors.New("Sry, incorrect params")
	}
	
	wg := sync.WaitGroup{}
	for dy := 0; dy < canvas.Height; dy++ {
		for dx := 0; dx < canvas.Width; dx++ {
			y := float64(dy)/float64(canvas.Height)
			x := float64(dx)/float64(canvas.Width)
			wg.Add(1)
			canvas.Set(dx, dy, m.GetColor(complex(y, x)))
			wg.Done()
		}
	}
	return nil 
}
