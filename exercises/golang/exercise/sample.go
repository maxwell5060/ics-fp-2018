package exercise

import (
	"github.com/dikderoy/imagen/drawer"
	"image/color"
	"math/cmplx"
	"sync"
)

// I've read this article to get prepared for this lab http://web.colby.edu/danelson/cs333-programming-languages/go/go-mandelbrot-set-tutorial/

//My program was tested by modifying configs to check parallel work of goroutine 

//First of all, we gotta define structure with all fields corresponding to NewMandelbrot param-s
type Mandelbrot struct {
	iterations  int
	scaleFactor float32
	offsetX     float32
	offsetY     float32
}


func NewMandelbrot(iterations int, scaleFactor float32, offsetX, offsetY float32) drawer.MandelbrotGenerator {
		/* So here we have to create function which matches contract of interface MandelbrotGenerator
		we have to implement 2 general methods Generate and GenerateParallel for concurrent go work.
	    */
	return Mandelbrot{iterations,scaleFactor,offsetX,offsetY}
}

//not parallel implementation, just going through screen coords and set pixels to black or white colors
//nothing really special here
func (m Mandelbrot) Generate(canvas *drawer.Image) error {
	for y := 0; y < canvas.Height; y++ {
		for x := 0; x < canvas.Width; x++ {
			canvas.Set(x, y, m.getColor(m.crdDot(x, y, canvas.Width, canvas.Height)))
		}
	}
	return nil
}

//here we have to implement parallel work of ge
func (m Mandelbrot) GenerateParallel(canvas *drawer.Image) error {
	/*just using one of the simpliest sync instruments in Go - wait groups
	we gotta use them to wait for long timed process completion from main
	in other case program may finishes before we get right result from this thread 
    */
	wg := sync.WaitGroup{}
	for y := 0; y < canvas.Height; y++ {
		for x := 0; x < canvas.Width; x++ {
			//kinda block group till we get 0 in wg, here we add running task there
			wg.Add(1)
			//starting goroutine here (parallel function)
			go func (x,y int) {
				canvas.Set(x, y, m.getColor(m.crdDot(x, y, canvas.Width, canvas.Height)))
				//release blocking when long-timed part of process is done
				wg.Done()
			}(x,y)
		}
	}
	return nil
}

//just auxiliary function to calculate complex representation of coord-s of every dot 
func (m Mandelbrot) crdDot(x int, y int, width int, height int) complex128 {
	Ycrd := float64(y)/float64(height)*(2)-1
	Xcrd := float64(x)/float64(width)*(2.5)-2
	return complex(Xcrd, Ycrd)
}

//just making decision if dot belongs to Mandelbrot set
func (m Mandelbrot) getColor(c complex128) color.Color {
	var z complex128
	var i = 0;
	for ; i < m.iterations && cmplx.Abs(z) <=2; i++ {
		//main formula of Mbr set: Zn+1 = Zn^2 + C
		z = (z*z) + c
	}
	if cmplx.Abs(z) <= 2 {
		//all dots in Mandelbrot set we color in black (optionally could change it to RED/BLUE f.e.)
		return color.YCbCr{Y: 16, Cb: 128, Cr:128} 
	}
	//we just use white for all other dots that don't match Mandelbrot set conditions
	return color.YCbCr{Y: 235, Cb: 128, Cr: 128} 
}