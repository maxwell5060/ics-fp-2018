package exercise

import (
	"github.com/dikderoy/imagen/drawer"
	log "github.com/sirupsen/logrus"
	"image/color"
	"math"
	"sync"
	"time"
)

type Mandelbrot struct {
	iterations  int
	scaleFactor float32
	offsetX, offsetY float32
}


func NewMandelbrot(iterations int, scaleFactor float32, offsetX, offsetY float32) drawer.MandelbrotGenerator {
	return Mandelbrot{iterations:iterations, scaleFactor:scaleFactor, offsetX:offsetX, offsetY:offsetY}
}

func (man Mandelbrot) Generate(canvas *drawer.Image) error {

	max := float32(10)
	
	start := time.Now()

	for ix := 0; ix < canvas.Width; ix++ {
		var x float32
		var y float32
		for iy := 0; iy < canvas.Height; iy++ {

			cx := (man.scaleFactor * float32(ix)) - man.offsetX
			cy := (man.scaleFactor * float32(iy)) - man.offsetY

			x = cx
			y = cy
			i := 0

			for i < man.iterations {

				x, y = x * x - y * y + cx, 2 * x * y + cy
	
				if (float32(math.Abs(float64(x)))>(max)) && (float32(math.Abs(float64(y)))>(max)) {
					break
				}
				i++
			}

			if i < man.iterations {
				hue := i*14+600
				canvas.Set(ix, iy, manColor(float64(hue)))
			} else {
				canvas.Set(ix, iy, color.RGBA{0.0, 0.0, 0.0, 255})
			}
		}
	}
	elapsed := time.Since(start)
	log.Printf("Consecutive took %s", elapsed) //190 ms
	return nil
}

func (man Mandelbrot) GenerateParallel(canvas *drawer.Image) error {

	max := float32(10)

	var wg sync.WaitGroup
	
	start := time.Now()
	wg.Add(canvas.Width)

	for ix := 0; ix < canvas.Width; ix++ {

		var x float32
		var y float32

		go func(ix int) {
			for iy := 0; iy < canvas.Height; iy++ {

				cx := (man.scaleFactor * float32(ix)) - man.offsetX
				cy := (man.scaleFactor * float32(iy)) - man.offsetY

				x = cx
				y = cy
				i := 0

				for i < man.iterations {

					x, y = x * x - y * y + cx, 2 * x * y + cy
	
					if (float32(math.Abs(float64(x)))>(max)) && (float32(math.Abs(float64(y)))>(max)) {
						break
					}
					i++
				}

				if i < man.iterations {
					hue := i*14+600
					canvas.Set(ix, iy, manColor(float64(hue)))
				} else {
					canvas.Set(ix, iy, color.RGBA{0.0, 0.0, 0.0, 255})
				}
			} 
			wg.Done()
		}(ix)
	}
	wg.Wait()

	elapsed := time.Since(start)
	log.Printf("Parallel took %s", elapsed) // 100 ms
	return nil
}

func manColor(hue float64) color.RGBA {

	r, g, b := 0.0, 0.0, 0.0

	if (hue < 100.0) { 				//white
		r = 1.0
		g = 1.0
		b = 1.0
	} else if (hue >= 100.0 && hue < 200.0) {	//red
		r = 1.0 - (hue - 100.0)/200.0
		g = 0.0
		b = 0.0
	} else if (hue >= 200.0 && hue < 300.0) {	//yellow
		r = 1.0 - (hue - 200.0)/200.0
		g = 1.0 - (hue - 200.0)/200.0  
		b = 0.0
	} else if (hue >= 300.0 && hue < 400.0) {	//green
		r = 0.0
		g = 1.0 - (hue - 300.0)/200.0
		b = 0.0
	} else if (hue >= 400.0 && hue < 500.0) {	//light-blue
		r = 0.0
		g = 1.0 - (hue - 400.0)/200.0
		b = 1.0 - (hue - 400.0)/200.0
	} else if (hue >= 500.0 && hue < 600.0) {	//blue
		r = 0.0
		g = 0.0 
		b = 1.0 - (hue - 500.0)/200.0
	} else if (hue >= 600.0) {			//purple
		r = 1.0 - (hue - 600.0)/200.0
		g = 0.0  
		b = 1.0 - (hue - 600.0)/200.0
	}

	return color.RGBA{uint8(r*255), uint8(g*255), uint8(b*255), 255};
}