package exercise

import (
	//	log "github.com/sirupsen/logrus"
	"github.com/dikderoy/imagen/drawer"
	"image/color"
	"sync"
)

type Mandelbrot struct {
	iterations  int
	scaleFactor, offsetX, offsetY float32
}

func NewMandelbrot(iterations int, scaleFactor float32, offsetX, offsetY float32) drawer.MandelbrotGenerator {
	return Mandelbrot{iterations, scaleFactor, offsetX, offsetY}
}

func (mandelbrot Mandelbrot) GetColor(X, Y float64) color.Color {
	x := float64(0)
	xx := float64(0)
	y := float64(0)
	yy := float64(0)

	for i := 0; i < mandelbrot.iterations; i++ {
		//log.Info("Iteration : i = ", i, "/", mandelbrot.iterations);
		xx = x*x - y*y + X
		yy = 2.0*x*y + Y
		x = xx
		y = yy
		if x*x+y*y > 4 {
			return color.White
		}
	}

	return color.Black
}

func (mandelbrot Mandelbrot) Generate(window *drawer.Image) error {
	minX := float64(-5)
	sizeX := float64(10)
	minY := float64(-5)
	sizeY := float64(10)

	for x := 0; x < window.Width; x++ {
		for y := 0; y < window.Height; y++ {
			X := (minX + float64(x)/float64(window.Width) * sizeX) * float64(mandelbrot.scaleFactor) + float64(mandelbrot.offsetX)
			Y := (minY + float64(y)/float64(window.Height) * sizeY) * float64(mandelbrot.scaleFactor) + float64(mandelbrot.offsetY)
			window.Set(x, y, mandelbrot.GetColor(X, Y))
			//log.Info("Generate : x = ", x, "/", window.Width, " , y = ", y, "/", window.Height, " X = ", X, " Y = ", Y)
		}
	}
	return nil
}

func (mandelbrot Mandelbrot) GenerateParallel(window *drawer.Image) error {
	wg := sync.WaitGroup{}
	minX := float64(-5)
	sizeX := float64(10)
	minY := float64(-5)
	sizeY := float64(10)

	for x := 0; x < window.Width; x++ {
		for y := 0; y < window.Height; y++ {
			X := (minX + float64(x)/float64(window.Width) * sizeX) * float64(mandelbrot.scaleFactor) + float64(mandelbrot.offsetX)
			Y := (minY + float64(y)/float64(window.Height) * sizeY) * float64(mandelbrot.scaleFactor) + float64(mandelbrot.offsetY)
			wg.Add(1)
			window.Set(x, y, mandelbrot.GetColor(X, Y))
			//log.Info("GenerateParallel : x = ", x, "/", window.Width, " , y = ", y, "/", window.Height, " X = ", X, " Y = ", Y)
			wg.Done()
		}
	}
	return nil
}