package exercise

import (
	"image/color"
	"math/cmplx"
	"math/rand"
	"sync"
	"time"

	"github.com/dikderoy/imagen/drawer"
)

type Mandelbrot struct {
	iterations       int
	scaleFactor      float32
	offsetX, offsetY float32
}

func makeSlices(start float64, count int, step float64) []float64 {
	s := make([]float64, count)
	for i := range s {
		s[i] = start
		start += step
	}
	return s
}

func randomColor() color.RGBA {
	rand := rand.New(rand.NewSource(time.Now().UnixNano()))
	r := uint8(rand.Float32() * 255)
	g := uint8(rand.Float32() * 255)
	b := uint8(rand.Float32() * 255)

	return color.RGBA{r, g, b, 255}
}

func (m Mandelbrot) Generate(canvas *drawer.Image) error {
	const maxRadius = 2
	const infinityBorder = 2
	mandelColor := color.RGBA{0, 0, 0, 255}
	infinityColor := randomColor()

	heightStep := float64(2 * float64(maxRadius) / float64(canvas.Height) / float64(m.scaleFactor))
	heightSlices := makeSlices(-maxRadius, canvas.Height, heightStep)

	widthStep := float64(2 * float64(maxRadius) / float64(canvas.Width) / float64(m.scaleFactor))
	widthSlices := makeSlices(-maxRadius, canvas.Width, widthStep)

	for y := 0; y < canvas.Height; y++ {
		sliceYCoord := heightSlices[y]
		for x := 0; x < canvas.Width; x++ {
			sliceXCoord := widthSlices[x]
			c := complex(sliceXCoord-float64(m.offsetX), sliceYCoord-float64(m.offsetY))
			var z complex128
			col := mandelColor
			for k := uint8(0); k < uint8(m.iterations); k++ {
				z = cmplx.Pow(z, 2) + c
				if cmplx.Abs(z) > infinityBorder {
					col = infinityColor
					if k != 0 {
						col.R = (col.R * k) % 255
						col.G = (col.G * k) % 255
						col.B = (col.B * k) % 255
					}
					break
				}
			}
			canvas.Set(x, y, col)
		}
	}

	return nil
}

func (m Mandelbrot) GenerateParallel(canvas *drawer.Image) error {
	const maxRadius = 2
	const infinityBorder = 2
	mandelColor := color.RGBA{0, 0, 0, 255}
	infinityColor := randomColor()

	heightStep := float64(2 * float64(maxRadius) / float64(canvas.Height) / float64(m.scaleFactor))
	heightSlices := makeSlices(-maxRadius, canvas.Height, heightStep)

	widthStep := float64(2 * float64(maxRadius) / float64(canvas.Width) / float64(m.scaleFactor))
	widthSlices := makeSlices(-maxRadius, canvas.Width, widthStep)

	wg := sync.WaitGroup{}

	for y := 0; y < canvas.Height; y++ {
		sliceYCoord := heightSlices[y]
		for x := 0; x < canvas.Width; x++ {
			sliceXCoord := widthSlices[x]
			c := complex(sliceXCoord-float64(m.offsetX), sliceYCoord-float64(m.offsetY))
			wg.Add(1)
			go func(px, py int) {
				var z complex128
				col := mandelColor
				for k := uint8(0); k < uint8(m.iterations); k++ {
					z = cmplx.Pow(z, 2) + c
					if cmplx.Abs(z) > infinityBorder {
						col = infinityColor
						if k != 0 {
							col.R = (col.R * k) % 255
							col.G = (col.G * k) % 255
							col.B = (col.B * k) % 255
						}
						break
					}
				}
				canvas.Set(px, py, col)
				wg.Done()
			}(x, y)
		}
	}

	return nil
}

func New(iterations int, scaleFactor float32, offsetX, offsetY float32) drawer.MandelbrotGenerator {
	m := Mandelbrot{iterations, scaleFactor, offsetX, offsetY}
	return m
}
