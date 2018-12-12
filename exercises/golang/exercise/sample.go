package exercise

import (
	"github.com/dikderoy/imagen/drawer"
	log "github.com/sirupsen/logrus"
	"image/color"
	"sync"
	"time"
)

type Mandelbrot struct {
	iterations       int
	scaleFactor      float32
	offsetX, offsetY float32
}

func NewMandelbrot(iterations int, scaleFactor float32, offsetX, offsetY float32) drawer.MandelbrotGenerator {
	return Mandelbrot{iterations, scaleFactor, offsetX, offsetY}
}

func (prms Mandelbrot) Generate(canvas *drawer.Image) error {
	start := time.Now()
	const border = 4
	h := canvas.Height
	w := canvas.Width
	for i := 0; i < h; i++ {
		for j := 0; j < w; j++ {
			cy := float32(i)*prms.scaleFactor - prms.offsetY
			cx := float32(j)*prms.scaleFactor - prms.offsetX

			tx := float32(0)
			ty := float32(0)
			for it := 0; it < prms.iterations; it++ {
				tx, ty = tx*tx-ty*ty+cx, 2*tx*ty+cy
				if tx*tx+ty*ty > border {
					canvas.Set(j, i, color.RGBA{255 - 5*uint8(it), 255 - 5*uint8(it), 255 - 5*uint8(it), 255})
					break
				}
			}
			if tx*tx+ty*ty < border {
				canvas.Set(j, i, color.RGBA{0, 0, 0, 255})
			}

		}
	}
	log.Println(time.Since(start))
	return nil
}
func (prms Mandelbrot) GenerateParallel(canvas *drawer.Image) error {
	start := time.Now()
	const border = 4
	h := canvas.Height
	w := canvas.Width
	wg := sync.WaitGroup{}

	for i := 0; i < h; i++ {
		for j := 0; j < w; j++ {
			cy := float32(i)*prms.scaleFactor - prms.offsetY
			cx := float32(j)*prms.scaleFactor - prms.offsetX
			wg.Add(1)
			go func(i, j int) {
				tx := float32(0)
				ty := float32(0)
				for it := 0; it < prms.iterations; it++ {
					tx, ty = tx*tx-ty*ty+cx, 2*tx*ty+cy
					if tx*tx+ty*ty > border {
						canvas.Set(j, i, color.RGBA{255 - 5*uint8(it), 255 - 5*uint8(it), 255 - 5*uint8(it), 255})
						break
					}
				}
				if tx*tx+ty*ty < border {
					canvas.Set(j, i, color.RGBA{0, 0, 0, 255})
				}
				wg.Done()
			}(i, j)
		}
	}
	log.Println(time.Since(start))
	return nil
}
