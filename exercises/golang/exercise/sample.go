package exercise

import (
	"github.com/dikderoy/imagen/drawer"
	"image/color"
	"math/rand"
	"math"
	"sync"
)

var cTable []color.RGBA // randomly filled color table
const floatEqualityThreshold = 1e-3 
const defaultStep = 0.02

func initColorTable(iter int) {
	cTable = make([]color.RGBA, iter)

	rand.Seed(1544881042332824500) 
	for i := 0; i < cap(cTable); i++ {
		cTable[i] = color.RGBA{
			uint8(rand.Intn(256)), uint8(rand.Intn(256)), 
			uint8(rand.Intn(256)), 255}
	}
}

type MyMandelbrot struct {
	iter int
	scaleFactor float32
	offsetRe, offsetIm float32
}

func (mg MyMandelbrot) Generate(canvas *drawer.Image) error {
	var (
		h = canvas.Height
		w = canvas.Width
		step, re_min, im_min float32 
	)
	// if scale factor is not set (= 0) use default step
	if math.Abs(float64(mg.scaleFactor) - 0) <= floatEqualityThreshold {
		step = defaultStep
	} else {
		step = defaultStep*mg.scaleFactor
	}
	
	initColorTable(mg.iter)
	
	// define left corner coordinates of a complex plane for projection
	re_min = mg.offsetRe - float32(w/2)*step
	im_min = mg.offsetIm - float32(h/2)*step
	
	for i := 0; i < h; i++ {
		for j := 0; j < w; j++ {
			fillPixel(canvas, i, j, mg.iter, re_min, im_min, step)
		}
	}
	return nil
}

func mandelbrotEquation(x, y float32, iter int) (k int) {
	var zx, zy float32 = 0., 0.
	for k = 0; (zx*zx + zy*zy < 4) && k < iter; k++ {
		zx, zy = (zx*zx - zy*zy + x), (2*zx*zy + y)
	}
	return k
}

func fillPixel(canvas *drawer.Image, i, j, iter int, re_min, im_min, step float32) {
	// derive complex plane coordinates from the image coordinates
	im := im_min + float32(i)*step
	re := re_min + float32(j)*step 

	color_ind := mandelbrotEquation(re, im, iter)
	canvas.Set(j, i, cTable[color_ind-1])
}

func (mg MyMandelbrot) GenerateParallel(canvas *drawer.Image) error {
	var (
		h = canvas.Height
		w = canvas.Width
		step, re_min, im_min float32 
		wg sync.WaitGroup
	)
	// if scale factor is not set (= 0) use default step
	if math.Abs(float64(mg.scaleFactor) - 0) <= floatEqualityThreshold {
		step = defaultStep
	} else {
		step = defaultStep*mg.scaleFactor
	}
	
	initColorTable(mg.iter)
	
	// define left corner coordinates of a complex plane for projection
	re_min = mg.offsetRe - float32(w/2)*step
	im_min = mg.offsetIm - float32(h/2)*step
	
	wg.Add(h)
	for i := range canvas.BitMap {
		go func(i int) {
			for j := range canvas.BitMap[i] {
				fillPixel(canvas, i, j, mg.iter, re_min, im_min, step)
			}
			wg.Done()
		}(i)
	}
	wg.Wait()
	return nil
}

func NewMandelbrot(iter int, scaleFactor float32, offsetX, offsetY float32) drawer.MandelbrotGenerator {
	return MyMandelbrot{iter, scaleFactor, offsetX, offsetY}
}