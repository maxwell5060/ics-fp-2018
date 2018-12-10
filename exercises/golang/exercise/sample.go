package exercise

import (
	"github.com/dikderoy/imagen/drawer"

	// log "github.com/sirupsen/logrus"

	"image/color"
	"math/cmplx"
	"sync"
)

type CustomMandelbrotGenerator struct {
	iterations  int
	scaleFactor float32
	offsetX     float32
	offsetY     float32

	xmin float64
	xmax float64
	ymin float64
	ymax float64

	superSampling int

	Color func(z complex128) color.Color
}

func NewMandelbrot(iterations int, scaleFactor float32, offsetX, offsetY float32) drawer.MandelbrotGenerator {
	return CustomMandelbrotGenerator{
		iterations:  iterations,
		scaleFactor: scaleFactor,
		offsetX:     offsetX,
		offsetY:     offsetY,

		xmin: -2,
		xmax: +2,
		ymin: -2,
		ymax: +2,

		superSampling: 5,

		Color: ColorFunction(iterations, 15),
	}
}

// Implement interface MandelbrotGenerator for CustomMandelbrotGenerator

func (cmg CustomMandelbrotGenerator) Generate(canvas *drawer.Image) error {
	width, height := canvas.Width, canvas.Height
	for py := 0; py < height; py++ {
		for px := 0; px < width; px++ {
			ssp := cmg.SupersampledPixel(cmg.superSampling, width, height, px, py)
			canvas.Set(px, py, ssp)
		}
	}

	return nil
}

func (cmg CustomMandelbrotGenerator) GenerateParallel(canvas *drawer.Image) error {
	width, height := canvas.Width, canvas.Height
	// log.Info("canvas width:", canvas.Width, "(", width, "); canvas height:", canvas.Height, "(", height, ")")

	wg := sync.WaitGroup{}
	mx := sync.Mutex{}

	for py := 0; py < height; py++ {
		for px := 0; px < width; px++ {
			wg.Add(1)

			go func(px, py, width, height int) {
				ssp := cmg.SupersampledPixel(cmg.superSampling, width, height, px, py)

				mx.Lock()
				canvas.Set(px, py, ssp)
				mx.Unlock()

				wg.Done()
			}(px, py, width, height)
		}
	}

	wg.Wait()

	return nil
}

func (cmg CustomMandelbrotGenerator) Pixel(fr func(z complex128) color.Color, width, height int, pointx, pointy int) color.Color {
	x := float64(pointx)/float64(width)*(cmg.xmax-cmg.xmin) + cmg.xmin
	y := float64(pointy)/float64(height)*(cmg.ymax-cmg.ymin) + cmg.ymin
	z := complex(x, y)

	return fr(z)
}

func (cmg *CustomMandelbrotGenerator) SupersampledPixel(multiplier int, width, height int, pointx, pointy int) color.Color {
	var avgColor color.RGBA
	total := 0 // up to multiplier * multiplier

	bx := pointx * multiplier
	by := pointy * multiplier
	for dxp := 0; dxp < multiplier; dxp++ {
		for dyp := 0; dyp < multiplier; dyp++ {
			col_ := cmg.Pixel(cmg.Color, width*multiplier, height*multiplier, bx+dxp, by+dyp)
			col := ColorToRGBA(col_)
			avgColor = color.RGBA{
				uint8((int(avgColor.R)*total + int(col.R)) / (total + 1)),
				uint8((int(avgColor.G)*total + int(col.G)) / (total + 1)),
				uint8((int(avgColor.B)*total + int(col.B)) / (total + 1)),
				uint8((int(avgColor.A)*total + int(col.A)) / (total + 1)),
			}

			total += 1
		}
	}

	return avgColor
}

func ColorToRGBA(col color.Color) color.RGBA {
	r, g, b, a := col.RGBA()
	return color.RGBA{uint8(r), uint8(g), uint8(b), uint8(a)}
}

func ColorFunction(iterations, contrast int) func(complex128) color.Color {
	return func(z complex128) color.Color {
		return MandelbrotColorFunction(z, iterations, contrast)
	}
}

func MandelbrotColorFunction(z complex128, iterations, contrast int) color.Color {
	var v complex128
	for n := 0; n < iterations; n++ {
		v = v*v + z
		if cmplx.Abs(v) > 2 {
			return color.RGBA{0xcc, 255 - uint8(contrast*n), 255 - uint8(contrast*n), 0xff}
		}
	}
	return color.Black
}
