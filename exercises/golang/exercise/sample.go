package exercise

import (
	"github.com/dikderoy/imagen/drawer"
	"image/color"
	"math/cmplx"
	"sync"
)

type MandelbrotPlotter interface {
	Make_Z(pixel complex128) complex128
}

type Mandelbrot struct {
	offset complex128
	scale float64
	iterations int
}

func NewMandelbrot(iterations int, scaleFactor float64, offsetX, offsetY float64) drawer.MandelbrotGenerator {
	return Mandelbrot{complex(offsetX, offsetY), scaleFactor, iterations};
}

func (m Mandelbrot) Make_Z(pixel complex128) complex128 {
	return complex(real(m.offset) + real(pixel) * m.scale, imag(m.offset) + imag(pixel) * m.scale);
}

func (m Mandelbrot) Make_mandelbrot(z complex128) int {
	ya_z := complex(0.0, 0.0)
	var i int = 0
	for ; i < m.iterations && cmplx.Abs(ya_z) < 2; i++ {
		ya_z = ya_z * ya_z + z
	}
	return i
}

func Make_color(num int) color.RGBA {
	return color.RGBA{uint8(num % 256), uint8(num % 256), uint8(num % 256), 255}
}

func (m Mandelbrot) Generate(canvas *drawer.Image) error {
	for y := 0; y < canvas.Height; y++ {
		for x := 0; x < canvas.Width; x++ {		
			z := m.Make_Z(complex(float64(x), float64(y)))
			n := m.Make_mandelbrot(z)
			color := Make_color(n)
			canvas.Set(x, y, color)
		}
	}
	return nil
}

func (m Mandelbrot) GenerateParallel(canvas *drawer.Image) error {
	var wg sync.WaitGroup
	wg.Add(canvas.Height)
	for y := 0; y < canvas.Height; y++ {
		go func(y int) {
			for x := 0; x < canvas.Width; x++ {		
				z := m.Make_Z(complex(float64(x), float64(y)))
				n := m.Make_mandelbrot(z)
				color := Make_color(n)
				canvas.Set(x, y, color)
			}
			wg.Done()
		}(y)
	}
	wg.Wait()
	return nil
}