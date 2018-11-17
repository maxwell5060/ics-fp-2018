package exercise

import (
	_ "github.com/sirupsen/logrus"
	_ "image/color"
	"github.com/imagen/exercise/golang/drawer"
	"image/color"
	"errors"
	"math"
	"sync"
)

type Mandelbrot struct{
	iterations int
	scaleFactor float32
	offsetX, offsetY float32
	}

func (mandelbrot Mandelbrot) Generate(canvas *drawer.Image) error {

	if (mandelbrot.iterations <= 0) {
		return errors.New("Incorrect params")
	}

	limit := float32(4)
	halfWidth := canvas.Width / 2

	halfHeight := canvas.Height / 2

	for y := -halfHeight; y <= halfHeight; y++ {
		ay := mandelbrot.offsetY + (float32(y) * mandelbrot.scaleFactor)

		for x := -halfWidth; x < halfWidth; x++ {
			ax := mandelbrot.offsetX + (float32(x) * mandelbrot.scaleFactor)
			a1 := ax
			b1 := ay
			numIterations := 0
			for ; numIterations < mandelbrot.iterations; {
				numIterations++
				a2 := (a1 * a1) - (b1 * b1) + ax
				b2 := (2 * a1 * b1) + ay
				if (a2*a2)+(b2*b2) > limit {
					break
				}
				numIterations++
				a1 = (a2 * a2) - (b2 * b2) + ax
				b1 = (2 * a2 * b2) + ay
				if (a1*a1)+(b1*b1) > limit {
					break
				}
			}
			if numIterations < mandelbrot.iterations {

				index := numIterations % 512
				wave := 380.0 + (index * 400.0 / 512)

				canvas.Set(x+halfWidth, y+halfHeight, getColor(float64(wave)))

			} else {
				n := byte(a1 * b1)
				canvas.Set(x+halfWidth, y+halfHeight, color.RGBA{n, n, n, 255})
			}
		}
	}

	return nil
}

func (mandelbrot Mandelbrot) GenerateParallel(canvas *drawer.Image) error {
	if (mandelbrot.iterations <= 0) {
		return errors.New("Incorrect params")
	}

	limit := float32(4)
	halfWidth := canvas.Width / 2
	halfHeight := canvas.Height / 2

	workers := 3
	var wg sync.WaitGroup

	for y := -halfHeight; y <= halfHeight; y++ {
		ay := mandelbrot.offsetY + (float32(y) * mandelbrot.scaleFactor)

		for x := -halfWidth; x < halfWidth; x++ {
			ax := mandelbrot.offsetX + (float32(x) * mandelbrot.scaleFactor)
			a1 := ax
			b1 := ay
			numIterations := 0
			for ; numIterations < mandelbrot.iterations; {
				wg.Add(workers)

				c1 := make(chan int, 1)
				go func() {
					numIterations++
					c1 <- numIterations
					wg.Done()
				}()
				numIterations = <- c1
				close(c1)

				c2 := make(chan float32, 1)
				go func() {
					c2 <- (a1 * a1) - (b1 * b1) + ax
					wg.Done()
				}()
				a2 := <-c2
				close(c2)


				c3 := make(chan float32, 1)
				go func() {
					c3 <- (2 * a1 * b1) + ay
					wg.Done()
				}()
				b2 := <-c3
				close(c3)

				wg.Wait()

				if (a2*a2)+(b2*b2) > limit {
					break
				}

				wg.Add(workers)

				c4 := make(chan int, 1)
				go func() {
					numIterations++
					c4 <- numIterations
					wg.Done()
				}()
				numIterations = <- c4
				close(c4)

				c5 := make(chan float32, 1)
				go func() {
					c5 <- (a2 * a2) - (b2 * b2) + ax
					wg.Done()
				}()
				a1 = <- c5
				close(c5)

				c6 := make(chan float32, 1)
				go func() {
					c6 <- (2 * a2 * b2) + ay
					wg.Done()
				}()
				b1 = <- c6
				close(c6)

				wg.Wait()

				if (a1*a1)+(b1*b1) > limit {
					break
				}
			}
			if numIterations < mandelbrot.iterations {
				index := numIterations % 512
				wave := 380.0 + (index * 400.0 / 512)

				canvas.Set(x+halfWidth, y+halfHeight, getColor(float64(wave)))
			} else {
				n := byte(a1 * b1)
				canvas.Set(x+halfWidth, y+halfHeight, color.RGBA{n, n, n, 255})
			}

		}
	}

	return nil
}

func NewMandelbrot(iterations int, scaleFactor float32, offsetX, offsetY float32) drawer.MandelbrotGenerator {
	//start here
	res := Mandelbrot{iterations, scaleFactor, offsetX, offsetY}
	return res
}

func getColor(wave float64) color.RGBA {
	red := 0.0;
	green := 0.0;
	blue := 0.0;
	if (wave >= 380.0 && wave <= 440.0) {
		red = -1.0 * (wave - 440.0) / (440.0 - 380.0);
		blue = 1.0;
	} else if (wave >= 440.0 && wave <= 490.0) {
		green = (wave - 440.0) / (490.0 - 440.0);
		blue = 1.0;
	} else if (wave >= 490.0 && wave <= 510.0) {
		green = 1.0;
		blue = -1.0 * (wave - 510.0) / (510.0 - 490.0);
	} else if (wave >= 510.0 && wave <= 580.0) {
		red = (wave - 510.0) / (580.0 - 510.0);
		green = 1.0;
	} else if (wave >= 580.0 && wave <= 645.0) {
		red = 1.0;
		green = -1.0 * (wave - 645.0) / (645.0 - 580.0);
	} else if (wave >= 645.0 && wave <= 780.0) {
		red = 1.0;
	}

	s := 1.0;
	if (wave > 700.0) {
		s = 0.3 + 0.7*(780.0-wave)/(780.0-700.0);
	}
	if (wave < 420.0) {
		s = 0.3 + 0.7*(wave-380.0)/(420.0-380.0);
	}
	red = math.Pow(red*s, 0.8) * 255;
	green = math.Pow(green*s, 0.8) * 255;
	blue = math.Pow(blue*s, 0.8) * 255;
	return color.RGBA{uint8(red), uint8(green), uint8(blue), 255};
}
