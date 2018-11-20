package exercise

import (
	"drawer"
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

func (m Mandelbrot) Generate(canvas *drawer.Image) error {
	const space = 3
	for y := 0; y < canvas.Height; y++ {
		for x := 0; x < canvas.Width; x++ {
			pixelY := -space + float64(y)/float64(canvas.Height)*(space*2)
			pixelX := -space + float64(x)/float64(canvas.Width)*(space*2)
			canvas.Set(x, y, m.getPixel(complex(pixelX, pixelY)))
		}
	}
	return nil
}


func (m Mandelbrot) GenerateParallel(canvas *drawer.Image) error {
	
	wg := sync.WaitGroup{}
	const space = 3
	for y := 0; y < canvas.Height; y++ {
		for x := 0; x < canvas.Width; x++ {
			pixelY := -space + float64(y)/float64(canvas.Height)*(space*2)
			pixelX := -space + float64(x)/float64(canvas.Width)*(space*2)
			wg.Add(1)
			canvas.Set(x, y, m.getPixel(complex(pixelY, pixelX)))
			wg.Add(1)
			
		}
	}
	return nil
}

func (m Mandelbrot) getPixel(xy complex128) color.Color {
	var f complex128
	var i = 0
	for ; i < m.iterations && cmplx.Abs(f) <= 2; i++ {
		//function F = y=x^3 + x^2 + C
		f = (f*f*f) + (f*f) + xy
	}
	if cmplx.Abs(f) <= 4 { return color.YCbCr{Y: 66, Cb: 73, Cr:73}}
	if(i == 1){ return color.YCbCr{Y: 40,  Cb: 116, Cr: 166}}
	if(i == 2){ return color.YCbCr{Y: 211, Cb: 84,  Cr: 11}}
	return color.YCbCr{Y: 244, Cb: 208, Cr: 63}
}



