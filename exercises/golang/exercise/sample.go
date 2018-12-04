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

	if mandelbrot.iterations <= 0 || canvas.Height <= 0 || canvas.Width <= 0 {
		return errors.New("Incorrect params")
	}

	limit := float64(4)
	for y := 0; y < canvas.Height; y++ {

		ay := (mandelbrot.scaleFactor * float32(y)) - mandelbrot.offsetY

		for x := 0; x < canvas.Width; x++ {

			ax := (mandelbrot.scaleFactor * float32(x)) - mandelbrot.offsetX
			a := float32(ax)
			b := float32(ay)
			numIterations := 0

			for numIterations < mandelbrot.iterations {

				aTemp := a*a - b*b + ax
				bTemp := 2*a*b + ay
				a = aTemp
				b = bTemp

				if math.Abs(float64(aTemp)) > limit && math.Abs(float64(bTemp)) > limit {
					break
				}

				numIterations++

			}
			if numIterations < mandelbrot.iterations {
				index := numIterations % 512
				wave := 380.0 + (index * 400.0 / 512)
				canvas.Set(x, y, getColor(float64(wave)))
			} else {
				n := byte(ax * ay)
				canvas.Set(x, y, color.RGBA{n, n, n, 255})
			}
		}
	}

	return nil
}

func (mandelbrot Mandelbrot) GenerateParallel(canvas *drawer.Image) error {
	if mandelbrot.iterations <= 0 || canvas.Height <= 0 || canvas.Width <= 0 {
		return errors.New("Incorrect params")
	}

	limit := float64(4)

	var wg sync.WaitGroup
	wg.Add(canvas.Height)


	for y := 0; y < canvas.Height; y++ {

		go func(y int) {

			ay := (mandelbrot.scaleFactor * float32(y)) - mandelbrot.offsetY

			for x := 0; x < canvas.Width; x++ {
				ax := (mandelbrot.scaleFactor * float32(x)) - mandelbrot.offsetX
				a := float32(ax)
				b := float32(ay)
				numIterations := 0

				for numIterations < mandelbrot.iterations {

					aTemp := a*a - b*b + ax
					bTemp := 2*a*b + ay
					a = aTemp
					b = bTemp

					if math.Abs(float64(aTemp)) > limit && math.Abs(float64(bTemp)) > limit {
						break
					}

					numIterations++

				}
				if numIterations < mandelbrot.iterations {
					index := numIterations % 512
					wave := 380.0 + (index * 400.0 / 512)

					canvas.Set(x, y, getColor(float64(wave)))
				} else {
					n := byte(ax * ay)
					canvas.Set(x, y, color.RGBA{n, n, n, 255})
				}
			}
			wg.Done()
		}(y)
	}

	wg.Wait()

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

