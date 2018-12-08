package exercise

import (
	"github.com/dikderoy/imagen/drawer"
	"image/color"
	"math"
	"sync"
)

// This func  is gonna initialize our Mandelbrot
func NewMandelbrot(iterations int, scaleFactor float32, offsetX, offsetY float32) drawer.MandelbrotGenerator {


	return Mandelbrot{
		iterations:  iterations,
		scaleFactor: scaleFactor,
		offsetX:     offsetX,
		offsetY:     offsetY,
	}
}

// LET'S CREATE THE MANDELBROT STRUCTURE
type Mandelbrot struct {
	iterations       int
	scaleFactor      float32
	offsetX, offsetY float32
}



//Calculating the color in every pixel
func (figure Mandelbrot) Generate(canvas *drawer.Image) error {

	//Lets choose the maximal iteration number
	iterMax := float64(100)

	width := canvas.Width
	height := canvas.Height

	for px := 0; px < width; px ++ {
		var x0, y0 float32
		
		for py := 0; py < height; py++ {

			cx := (figure.scaleFactor * float32(px)) - figure.offsetX
			cy := (figure.scaleFactor * float32(py)) - figure.offsetY

			x0 = cx
			y0 = cy

			i := 0

			for i < figure.iterations {

				x0, y0 = x0 * x0 - y0 * y0 + cx, 2 * x0 * y0 + cy
	
				if math.Abs(float64(x0)) > iterMax &&  math.Abs(float64(y0)) > iterMax {
					//Means we are out of the max number of iterations
					break
				}

				i++
			}

			if i < figure.iterations {
				//Lets draw the background in white color
				canvas.Set(px, py, color.White)
			} else {
				// And here we draw the figure in black
				canvas.Set(px, py, color.Black)
			}
		}
	}
	
	return nil
	
}

// Calculating the color  in every pixel (in parallel )
func (figure Mandelbrot) GenerateParallel(canvas *drawer.Image) error {

	//Lets choose the maximal iteration number		
	iterMax := float64(100)

	width := canvas.Width
	height := canvas.Height

	var wg sync.WaitGroup
	wg.Add(width)
	
	
	for px := 0; px < width; px ++ {

		var x0 float32
		var y0 float32

		go func(px int) {

			for py := 0; py < height; py ++ {

				cx := (figure.scaleFactor * float32(px)) - figure.offsetX
				cy := (figure.scaleFactor * float32(py)) - figure.offsetY

				x0 = cx
				y0 = cy

				i := 0

				for i < figure.iterations {

					x0, y0 = x0 * x0 - y0 * y0 + cx, 2 * x0 * y0 + cy
	
					if math.Abs(float64(x0)) > iterMax &&  math.Abs(float64(y0)) > iterMax {
						//Means we are out of the max number of iterations
						break
					}

					i++
				}

				if i < figure.iterations {
					//Lets draw the background in white color
					canvas.Set(px, py, color.White)
				} else {
					//And here we draw the figure in black
					canvas.Set(px, py, color.Black)
				}
			} 
			wg.Done()
		}(px)
	}

	wg.Wait()
	return nil
	
}

